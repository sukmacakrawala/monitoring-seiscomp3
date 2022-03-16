#!/bin/bash
kode_stasiun=MND
tipe=seiscomp
hdd=$(df / | awk 'NR==2 {print $5}' | sed 's/\%//g')
datetime=$(date +"%Y-%m-%d %H:%m")
id=$(date +"%Y%m%d%H%m")

cd /home/sysop/remote_site

declare -a modul
if [ $tipe == "seiscomp" ]
then
   export modul=(spread scmaster arclink scwfparam seedlink slarchive)
else
   export modul=(spread scmaster arclink scwfparam)
fi


for i in "${modul[@]}"
do
##start looping
if [[ $(seiscomp status | grep -w $i | awk '{print $3}') == 'not' ]]
 then
  export $i=0
 else
 export  $i=1
fi
##stop looping
done



if [ $tipe == "seiscomp" ]
then
   let status=$spread+$scmaster+$arclink+$scwfparam+$seedlink+$slarchive
   echo "INSERT INTO tbl_mon_harian (id,kode_stasiun,tipe,hdd,waktu,status_spread,status_scmaster,status_arclink,status_scwfparam,status_seedlink,status_slarchive ) VALUES ('$id','$kode_stasiun','$tipe','$hdd','$datetime','$spread','$scmaster','$arclink','$scwfparam','$seedlink','$slarchive');" > $kode_stasiun.sql
echo "UPDATE tbl_mon_tampil SET scmp = $status , hdd_scmp = $hdd  WHERE kode_stasiun='$kode_stasiun';" >> $kode_stasiun.sql
else
   let status=$spread+$scmaster+$scwfparam
echo "INSERT INTO tbl_mon_harian (id,kode_stasiun,tipe,hdd,waktu,status_spread,status_scmaster,status_scwfparam ) VALUES ('$id','$kode_stasiun','$tipe','$hdd','$datetime','$spread','$scmaster','$scwfparam');" > $kode_stasiun.sql
echo "UPDATE tbl_mon_tampil SET shake = $status , hdd_shake = $hdd  WHERE kode_stasiun='$kode_stasiun';" >> $kode_stasiun.sql
fi


scp ${kode_stasiun}.sql root@172.19.1.59:/home/region/${tipe}/

echo $(date) >> log.txt
