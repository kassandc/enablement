Week1 README
## Environment ## 
 Ubuntu 24.04.3 LTS 

## Commands Run ## 
 1. Users and Permissions 
 id 
 sudo useradd seconduser 
 umask 0077 
 echo This is a secret file > labs/secret.txt 
 chmod 640 labs/secret.txt 

2. Processes and Disk 
 ps aux --sort=-%mem | head 
 df -h 

3. systemd + logs 
 systemctl list-units --type=service | head 
 systemctl status cron
 sudo journalctl -u cron -n 30 --no-pager


4. Text Pipeline 
 grep -v ^# /etc/group | awk -F: '{print }'

5. Navigation 
 grep -R secret . 
 find . -name *.md | xargs ls -l

