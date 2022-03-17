# monitoring-seiscomp3
Monitoring Agent Seiscomp3 With Bash Script


this is a script for monitoring that I made to find out the conditions and services I need on the seiscomp3 server in a remote location, I hope you can develop it for users of the seiscomp3 system

# Install
1. Create directory remote_site in /home/sysop
    $mkdir remote_site
2. Copy file seischeck.sh in folder remote_site
3. Edit and save file seischeck.sh and change some variable
   - kode_stasiun[station_code] : make sure your code registered on server
   - tipe[type] : in my case i have 2 condition seiscomp and shakemap, you can choice
  
4. Change the access permissions of file seischeck.sh 
   chmod +x seischeck.sh
5. Put script on crontab
   - crontab -e  
   - 1 * * * * /home/sysop/remote_site/seischek.sh
6. Make sure you can SSH to server without password
