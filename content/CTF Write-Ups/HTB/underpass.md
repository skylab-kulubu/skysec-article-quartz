---
title: Underpass
tags:
  - htb
  - easy
---

#### Author: **lomar**
![lomar](https://www.hackthebox.com/badge/image/1506415)

---

# Nmap (UDP Scan Required)
```plaintext
# Nmap 7.94SVN scan initiated Sat Jan  4 06:13:00 2025 as: /usr/lib/nmap/nmap --privileged -sT -A -v -sU -oA nmap 10.10.11.48
Increasing send delay for 10.10.11.48 from 50 to 100 due to 11 out of 12 dropped probes since last increase.
Increasing send delay for 10.10.11.48 from 800 to 1000 due to 11 out of 26 dropped probes since last increase.
Nmap scan report for 10.10.11.48
Host is up (0.095s latency).
Not shown: 998 closed tcp ports (conn-refused), 997 closed udp ports (port-unreach)
PORT     STATE         SERVICE VERSION
22/tcp   open          ssh     OpenSSH 8.9p1 Ubuntu 3ubuntu0.10 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   256 48:b0:d2:c7:29:26:ae:3d:fb:b7:6b:0f:f5:4d:2a:ea (ECDSA)
|_  256 cb:61:64:b8:1b:1b:b5:ba:b8:45:86:c5:16:bb:e2:a2 (ED25519)
80/tcp   open          http    Apache httpd 2.4.52 ((Ubuntu))
| http-methods: 
|_  Supported Methods: GET POST OPTIONS HEAD
|_http-title: Apache2 Ubuntu Default Page: It works
|_http-server-header: Apache/2.4.52 (Ubuntu)
161/udp  open          snmp    SNMPv1 server; net-snmp SNMPv3 server (public)
| snmp-info: 
|   enterprise: net-snmp
|   engineIDFormat: unknown
|   engineIDData: c7ad5c4856d1cf6600000000
|   snmpEngineBoots: 29
|_  snmpEngineTime: 1h17m59s
| snmp-sysdescr: Linux underpass 5.15.0-126-generic #136-Ubuntu SMP Wed Nov 6 10:38:22 UTC 2024 x86_64
|_  System uptime: 1h17m58.88s (467888 timeticks)
1812/udp open|filtered radius
1813/udp open|filtered radacct
No exact OS matches for host (If you know what OS is running on it, see https://nmap.org/submit/ ).
TCP/IP fingerprint:
OS:SCAN(V=7.94SVN%E=4%D=1/4%OT=22%CT=1%CU=2%PV=Y%DS=2%DC=T%G=Y%TM=67791C69%
OS:P=x86_64-pc-linux-gnu)SEQ(SP=104%GCD=1%ISR=100%TI=Z%CI=Z%TS=1)SEQ(SP=106
OS:%GCD=1%ISR=105%TI=Z%CI=Z%II=I%TS=9)SEQ(SP=106%GCD=1%ISR=105%TI=Z%CI=Z%II
OS:=I%TS=A)OPS(O1=M53CST11NW7%O2=M53CST11NW7%O3=M53CNNT11NW7%O4=M53CST11NW7
OS:%O5=M53CST11NW7%O6=M53CST11)WIN(W1=FE88%W2=FE88%W3=FE88%W4=FE88%W5=FE88%
OS:W6=FE88)ECN(R=Y%DF=Y%T=40%W=FAF0%O=M53CNNSNW7%CC=Y%Q=)T1(R=Y%DF=Y%T=40%S
OS:=O%A=S+%F=AS%RD=0%Q=)T2(R=N)T3(R=N)T4(R=Y%DF=Y%T=40%W=0%S=A%A=Z%F=R%O=%R
OS:D=0%Q=)T5(R=Y%DF=Y%T=40%W=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)T6(R=Y%DF=Y%T=40%W=
OS:0%S=A%A=Z%F=R%O=%RD=0%Q=)T7(R=N)U1(R=Y%DF=N%T=40%IPL=164%UN=0%RIPL=G%RID
OS:=G%RIPCK=G%RUCK=G%RUD=G)IE(R=Y%DFI=N%T=40%CD=S)

Uptime guess: 10.862 days (since Tue Dec 24 09:51:11 2024)
Network Distance: 2 hops
TCP Sequence Prediction: Difficulty=262 (Good luck!)
IP ID Sequence Generation: All zeros
Service Info: Host: UnDerPass.htb is the only daloradius server in the basin!; OS: Linux; CPE: cpe:/o:linux:linux_kernel

TRACEROUTE (using proto 1/icmp)
HOP RTT       ADDRESS
1   153.40 ms 10.10.14.1
2   153.43 ms 10.10.11.48

Read data files from: /usr/share/nmap
OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
# Nmap done at Sat Jan  4 06:32:57 2025 -- 1 IP address (1 host up) scanned in 1196.73 seconds

```

# Discovery
[**UDP/161 SNMP Scan**](https://book.hacktricks.wiki/en/network-services-pentesting/pentesting-snmp/index.html)
```bash
┌──(kali㉿kali)-[~/ctfs/underpass]
└─$ snmpbulkwalk -c public -v2c underpass.htb
iso.3.6.1.2.1.1.1.0 = STRING: "Linux underpass 5.15.0-126-generic #136-Ubuntu SMP Wed Nov 6 10:38:22 UTC 2024 x86_64"
iso.3.6.1.2.1.1.2.0 = OID: iso.3.6.1.4.1.8072.3.2.10
iso.3.6.1.2.1.1.3.0 = Timeticks: (507279) 1:24:32.79
iso.3.6.1.2.1.1.4.0 = STRING: "steve@underpass.htb"
iso.3.6.1.2.1.1.5.0 = STRING: "UnDerPass.htb is the only daloradius server in the basin!"
iso.3.6.1.2.1.1.6.0 = STRING: "Nevada, U.S.A. but not Vegas"
iso.3.6.1.2.1.1.7.0 = INTEGER: 72
iso.3.6.1.2.1.1.8.0 = Timeticks: (2) 0:00:00.02
iso.3.6.1.2.1.1.9.1.2.1 = OID: iso.3.6.1.6.3.10.3.1.1
iso.3.6.1.2.1.1.9.1.2.2 = OID: iso.3.6.1.6.3.11.3.1.1
iso.3.6.1.2.1.1.9.1.2.3 = OID: iso.3.6.1.6.3.15.2.1.1
iso.3.6.1.2.1.1.9.1.2.4 = OID: iso.3.6.1.6.3.1
iso.3.6.1.2.1.1.9.1.2.5 = OID: iso.3.6.1.6.3.16.2.2.1
iso.3.6.1.2.1.1.9.1.2.6 = OID: iso.3.6.1.2.1.49
iso.3.6.1.2.1.1.9.1.2.7 = OID: iso.3.6.1.2.1.50
iso.3.6.1.2.1.1.9.1.2.8 = OID: iso.3.6.1.2.1.4
iso.3.6.1.2.1.1.9.1.2.9 = OID: iso.3.6.1.6.3.13.3.1.3
iso.3.6.1.2.1.1.9.1.2.10 = OID: iso.3.6.1.2.1.92
iso.3.6.1.2.1.1.9.1.3.1 = STRING: "The SNMP Management Architecture MIB."
iso.3.6.1.2.1.1.9.1.3.2 = STRING: "The MIB for Message Processing and Dispatching."
iso.3.6.1.2.1.1.9.1.3.3 = STRING: "The management information definitions for the SNMP User-based Security Model."
iso.3.6.1.2.1.1.9.1.3.4 = STRING: "The MIB module for SNMPv2 entities"
iso.3.6.1.2.1.1.9.1.3.5 = STRING: "View-based Access Control Model for SNMP."
iso.3.6.1.2.1.1.9.1.3.6 = STRING: "The MIB module for managing TCP implementations"
iso.3.6.1.2.1.1.9.1.3.7 = STRING: "The MIB module for managing UDP implementations"
iso.3.6.1.2.1.1.9.1.3.8 = STRING: "The MIB module for managing IP and ICMP implementations"
iso.3.6.1.2.1.1.9.1.3.9 = STRING: "The MIB modules for managing SNMP Notification, plus filtering."
iso.3.6.1.2.1.1.9.1.3.10 = STRING: "The MIB module for logging SNMP Notifications."
iso.3.6.1.2.1.1.9.1.4.1 = Timeticks: (2) 0:00:00.02
iso.3.6.1.2.1.1.9.1.4.2 = Timeticks: (2) 0:00:00.02
iso.3.6.1.2.1.1.9.1.4.3 = Timeticks: (2) 0:00:00.02
iso.3.6.1.2.1.1.9.1.4.4 = Timeticks: (2) 0:00:00.02
iso.3.6.1.2.1.1.9.1.4.5 = Timeticks: (2) 0:00:00.02
iso.3.6.1.2.1.1.9.1.4.6 = Timeticks: (2) 0:00:00.02
iso.3.6.1.2.1.1.9.1.4.7 = Timeticks: (2) 0:00:00.02
iso.3.6.1.2.1.1.9.1.4.8 = Timeticks: (2) 0:00:00.02
iso.3.6.1.2.1.1.9.1.4.9 = Timeticks: (2) 0:00:00.02
iso.3.6.1.2.1.1.9.1.4.10 = Timeticks: (2) 0:00:00.02
iso.3.6.1.2.1.25.1.1.0 = Timeticks: (508381) 1:24:43.81
iso.3.6.1.2.1.25.1.2.0 = Hex-STRING: 07 E9 01 04 0B 27 03 00 2B 00 00 
iso.3.6.1.2.1.25.1.3.0 = INTEGER: 393216
iso.3.6.1.2.1.25.1.4.0 = STRING: "BOOT_IMAGE=/vmlinuz-5.15.0-126-generic root=/dev/mapper/ubuntu--vg-ubuntu--lv ro net.ifnames=0 biosdevname=0
"
iso.3.6.1.2.1.25.1.5.0 = Gauge32: 0
iso.3.6.1.2.1.25.1.6.0 = Gauge32: 279
iso.3.6.1.2.1.25.1.7.0 = INTEGER: 0
iso.3.6.1.2.1.25.1.7.0 = No more variables left in this MIB View (It is past the end of the MIB tree)
```

*UnDerPass.htb is the only daloradius server in the basin!*

![](https://raw.githubusercontent.com/skylab-kulubu/article/refs/heads/main/SKYSEC/Underpass/static/1.png)

![](https://github.com/skylab-kulubu/article/blob/main/SKYSEC/Underpass/static/1.png?raw=true)

# Web Login
![](https://github.com/skylab-kulubu/article/blob/main/SKYSEC/Underpass/static/3.png?raw=true)

![](https://github.com/skylab-kulubu/article/blob/main/SKYSEC/Underpass/static/4.png?raw=true)

![](https://github.com/skylab-kulubu/article/blob/main/SKYSEC/Underpass/static/5.png?raw=true)
## Hash Crack
![](https://github.com/skylab-kulubu/article/blob/main/SKYSEC/Underpass/static/6.png?raw=true)

# User Login
![](https://github.com/skylab-kulubu/article/blob/main/SKYSEC/Underpass/static/7.png?raw=true)
# Root
![](https://github.com/skylab-kulubu/article/blob/main/SKYSEC/Underpass/static/8.png?raw=true)
## Mosh Server
![](https://github.com/skylab-kulubu/article/blob/main/SKYSEC/Underpass/static/9.png?raw=true)
## Mosh Client
![](https://github.com/skylab-kulubu/article/blob/main/SKYSEC/Underpass/static/10.png?raw=true)

![](https://github.com/skylab-kulubu/article/blob/main/SKYSEC/Underpass/static/11.png?raw=true)