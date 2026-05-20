## WEEK1 - LINUX OPERATOR BASELINE ##

# Users and Permissions #

1. Show ID [COMMAND: id] 
 ID: uid=1001(k8s) gid=1001(k8s) groups=1001(k8s),27(sudo),1002(docker)

2. Create a Second User [COMMAND: sudo useradd seconduser] 
 seconduser:x:1005:1005::/home/seconduser:/bin/sh

3. Set umask to highly restrcited [COMMAND: umask 0077]
 0077

4. Create secret.txt file [COMMAND: echo This is a secret file > labs/secret.txt] 

 File Details: -rw------- 1 k8s k8s 22 May 20 15:42 labs/secret.txt

5. Change File Permission [COMMAND: chmod 640 labs/secret.txt]  
 File Details: -rw-r----- 1 k8s k8s 22 May 20 15:42 labs/secret.txt
 #changed file permission from 600 to 640 to show in the lab that the permission was changes. But for highly secured access, permission must be set to 600 (user/service account can only access)

# Processes and Disk #

1. Top 10 Memory Usage [COMMAND: ps aux --sort=-%mem | head]
 USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         357  0.0  0.4 2500172 68900 ?       Ssl  15:01   0:01 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
root         296  0.0  0.2 2088844 45116 ?       Ssl  15:01   0:02 /usr/bin/containerd
root         293  0.0  0.1 112592 22844 ?        Ssl  15:01   0:00 /usr/bin/python3 /usr/share/unattended-upgrades/unattended-upgrade-shutdown --wait-for-signal
root         174  0.0  0.1 336532 18492 ?        Ssl  15:01   0:00 /usr/sbin/NetworkManager --no-daemon
root          50  0.0  0.1  50556 17088 ?        S<s  15:01   0:00 /usr/lib/systemd/systemd-journald
postfix     2605  0.0  0.0  49612 13164 ?        S    15:10   0:00 tlsmgr -l -t unix -u -c
root           1  0.0  0.0  21772 13072 ?        Ss   15:01   0:01 /sbin/init
systemd+     111  0.0  0.0  21584 12880 ?        Ss   15:01   0:00 /usr/lib/systemd/systemd-resolved
k8s          935  0.0  0.0  20132 11212 ?        Ss   15:01   0:00 /usr/lib/systemd/systemd --user

2. Disk Usage in Human Readable [COMMAND: df -h] 
 Filesystem      Size  Used Avail Use% Mounted on
none            7.7G     0  7.7G   0% /usr/lib/modules/6.6.114.1-microsoft-standard-WSL2
none            7.7G  4.0K  7.7G   1% /mnt/wsl
drivers         468G  267G  202G  57% /usr/lib/wsl/drivers
/dev/sdd       1007G   15G  942G   2% /
none            7.7G   44K  7.7G   1% /mnt/wslg
none            7.7G     0  7.7G   0% /usr/lib/wsl/lib
rootfs          7.7G  2.8M  7.7G   1% /init
none            7.7G  180K  7.7G   1% /run
none            7.7G     0  7.7G   0% /run/lock
none            7.7G     0  7.7G   0% /run/shm
none            7.7G   80K  7.7G   1% /mnt/wslg/versions.txt
none            7.7G   80K  7.7G   1% /mnt/wslg/doc
C:\             468G  267G  202G  57% /mnt/c
tmpfs           1.6G   20K  1.6G   1% /run/user/1001

# systemd + logs #

1. List of Current Service Units [COMMAND: systemctl list-units --type=service | head] 
   UNIT                                     LOAD   ACTIVE SUB     DESCRIPTION
  containerd.service                       loaded active running containerd container runtime
  cron.service                             loaded active running Regular background program processing daemon
  dbus.service                             loaded active running D-Bus System Message Bus
  docker.service                           loaded active running Docker Application Container Engine
  getty@tty1.service                       loaded active running Getty on tty1
  ipvsadm.service                          loaded active exited  LSB: ipvsadm daemon
  kmod-static-nodes.service                loaded active exited  Create List of Static Device Nodes
  netfilter-persistent.service             loaded active exited  netfilter persistent configuration
  NetworkManager.service                   loaded active running Network Manager

2. Check Status of a Service [COMMAND: systemctl status cron] 
 ● cron.service - Regular background program processing daemon
     Loaded: loaded (/usr/lib/systemd/system/cron.service; enabled; preset: enabled)
     Active: active (running) since Wed 2026-05-20 15:01:53 +08; 1h 11min ago
       Docs: man:cron(8)
   Main PID: 131 (cron)
      Tasks: 1 (limit: 18843)
     Memory: 520.0K (peak: 2.3M)
        CPU: 29ms
     CGroup: /system.slice/cron.service
             └─131 /usr/sbin/cron -f -P

Warning: some journal files were not opened due to insufficient permissions.

3. View last 30 logs of cron service using journalctl [COMMAND: sudo journalctl -u cron -n 30 --no-pager] 
 May 19 18:17:01 KASSANDC01 CRON[38271]: (root) CMD (cd / && run-parts --report /etc/cron.hourly)
May 19 18:17:01 KASSANDC01 CRON[38270]: pam_unix(cron:session): session closed for user root
May 19 18:33:36 KASSANDC01 systemd[1]: Stopping cron.service - Regular background program processing daemon...
May 19 18:33:36 KASSANDC01 systemd[1]: cron.service: Deactivated successfully.
May 19 18:33:36 KASSANDC01 systemd[1]: Stopped cron.service - Regular background program processing daemon.
-- Boot 2b460c1bec1e4d4ca3955a4f7cd018dc --
May 20 11:08:01 KASSANDC01 systemd[1]: Started cron.service - Regular background program processing daemon.
May 20 11:08:01 KASSANDC01 (cron)[128]: cron.service: Referenced but unset environment variable evaluates to an empty string: EXTRA_OPTS
May 20 11:08:01 KASSANDC01 cron[128]: (CRON) INFO (pidfile fd = 3)
May 20 11:08:01 KASSANDC01 cron[128]: (root) INSECURE MODE (mode 0600 expected) (crontabs/root)
May 20 11:08:01 KASSANDC01 cron[128]: (CRON) INFO (Running @reboot jobs)
May 20 11:17:01 KASSANDC01 CRON[2901]: pam_unix(cron:session): session opened for user root(uid=0) by root(uid=0)
May 20 11:17:01 KASSANDC01 CRON[2902]: (root) CMD (cd / && run-parts --report /etc/cron.hourly)
May 20 11:17:01 KASSANDC01 CRON[2901]: pam_unix(cron:session): session closed for user root
May 20 13:17:01 KASSANDC01 CRON[16013]: pam_unix(cron:session): session opened for user root(uid=0) by root(uid=0)
May 20 13:17:01 KASSANDC01 CRON[16014]: (root) CMD (cd / && run-parts --report /etc/cron.hourly)
May 20 13:17:01 KASSANDC01 CRON[16013]: pam_unix(cron:session): session closed for user root
May 20 14:17:01 KASSANDC01 CRON[22129]: pam_unix(cron:session): session opened for user root(uid=0) by root(uid=0)
May 20 14:17:01 KASSANDC01 CRON[22130]: (root) CMD (cd / && run-parts --report /etc/cron.hourly)
May 20 14:17:01 KASSANDC01 CRON[22129]: pam_unix(cron:session): session closed for user root
May 20 14:56:37 KASSANDC01 systemd[1]: Stopping cron.service - Regular background program processing daemon...
May 20 14:56:37 KASSANDC01 systemd[1]: cron.service: Deactivated successfully.
May 20 14:56:37 KASSANDC01 systemd[1]: Stopped cron.service - Regular background program processing daemon.
-- Boot 17daa1bdd29c4b339e15b9a9b859f546 --
May 20 15:01:53 KASSANDC01 systemd[1]: Started cron.service - Regular background program processing daemon.
May 20 15:01:53 KASSANDC01 (cron)[131]: cron.service: Referenced but unset environment variable evaluates to an empty string: EXTRA_OPTS
May 20 15:01:53 KASSANDC01 cron[131]: (CRON) INFO (pidfile fd = 3)
May 20 15:01:53 KASSANDC01 cron[131]: (root) INSECURE MODE (mode 0600 expected) (crontabs/root)
May 20 15:01:53 KASSANDC01 cron[131]: (CRON) INFO (Running @reboot jobs)
May 20 15:17:01 KASSANDC01 CRON[3464]: pam_unix(cron:session): session opened for user root(uid=0) by root(uid=0)
May 20 15:17:01 KASSANDC01 CRON[3465]: (root) CMD (cd / && run-parts --report /etc/cron.hourly)
May 20 15:17:01 KASSANDC01 CRON[3464]: pam_unix(cron:session): session closed for user root

# Text Pipeline #
see labs/text-pipeline-sample.txt

# Navigation #

1. Search recursively in current directory [COMMAND: grep -R secret .] 
 ./labs/secret.txt:This is a secret file
./labs/week1-linux.md:4. Create secret.txt file [COMMAND: echo This is a secret file > labs/secret.txt] 
./labs/week1-linux.md: File Details: -rw------- 1 k8s k8s 22 May 20 15:42 labs/secret.txt
./labs/week1-linux.md:5. Change File Permission [COMMAND: chmod 640 labs/secret.txt]  
./labs/week1-linux.md: File Details: -rw-r----- 1 k8s k8s 22 May 20 15:42 labs/secret.txt

2. Find+xargs all files ending in .md [COMMAND: find . -name *.md | xargs ls -l] 
 -rw------- 1 k8s k8s   34 May 20 14:43 ./README.md
-rw-r--r-- 1 k8s k8s 8099 May 20 16:27 ./labs/week1-linux.md

