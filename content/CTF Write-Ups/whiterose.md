---
title: Whiterose
tags:
  - thm
  - easy
  - mrrobot
---

# _Welcome to Whiterose_

_This challenge is based on the Mr. Robot episode “409 Conflict”. Contains spoilers!_

_Go ahead and start the machine_**_, it may take a few minutes to fully start up._**

_And oh! I almost forgot! — You will need these:_ `Olivia Cortez:olivi8`

![](https://miro.medium.com/v2/resize:fit:700/0*PLK4Auluc49GiQlx.png)

# NMAP
```plain
# Nmap 7.94SVN scan initiated Wed Jan  1 07:04:59 2025 as: /usr/lib/nmap/nmap -sT -A -v -oA nmap 10.10.56.38  
Increasing send delay for 10.10.56.38 from 0 to 5 due to 78 out of 259 dropped probes since last increase.  
Nmap scan report for 10.10.56.38  
Host is up (0.12s latency).  
Not shown: 998 closed tcp ports (conn-refused)  
PORT   STATE SERVICE VERSION  
22/tcp open  ssh     OpenSSH 7.6p1 Ubuntu 4ubuntu0.7 (Ubuntu Linux; protocol 2.0)  
| ssh-hostkey:   
|   2048 b9:07:96:0d:c4:b6:0c:d6:22:1a:e4:6c:8e:ac:6f:7d (RSA)  
|   256 ba:ff:92:3e:0f:03:7e:da:30:ca:e3:52:8d:47:d9:6c (ECDSA)  
|_  256 5d:e4:14:39:ca:06:17:47:93:53:86:de:2b:77:09:7d (ED25519)  
80/tcp open  http    nginx 1.14.0 (Ubuntu)  
|_http-title: Site doesn't have a title (text/html).  
| http-methods:   
|_  Supported Methods: GET HEAD  
|_http-server-header: nginx/1.14.0 (Ubuntu)  
No exact OS matches for host (If you know what OS is running on it, see https://nmap.org/submit/ ).  
TCP/IP fingerprint:  
OS:SCAN(V=7.94SVN%E=4%D=1/1%OT=22%CT=1%CU=41874%PV=Y%DS=2%DC=T%G=Y%TM=67752  
OS:F90%P=x86_64-pc-linux-gnu)SEQ(SP=FF%GCD=1%ISR=107%TI=Z%CI=Z%II=I%TS=A)OP  
OS:S(O1=M509ST11NW6%O2=M509ST11NW6%O3=M509NNT11NW6%O4=M509ST11NW6%O5=M509ST  
OS:11NW6%O6=M509ST11)WIN(W1=F4B3%W2=F4B3%W3=F4B3%W4=F4B3%W5=F4B3%W6=F4B3)EC  
OS:N(R=Y%DF=Y%T=40%W=F507%O=M509NNSNW6%CC=Y%Q=)T1(R=Y%DF=Y%T=40%S=O%A=S+%F=  
OS:AS%RD=0%Q=)T2(R=N)T3(R=N)T4(R=Y%DF=Y%T=40%W=0%S=A%A=Z%F=R%O=%RD=0%Q=)T5(  
OS:R=Y%DF=Y%T=40%W=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)T6(R=Y%DF=Y%T=40%W=0%S=A%A=Z%  
OS:F=R%O=%RD=0%Q=)T7(R=Y%DF=Y%T=40%W=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)U1(R=Y%DF=N  
OS:%T=40%IPL=164%UN=0%RIPL=G%RID=G%RIPCK=G%RUCK=G%RUD=G)IE(R=Y%DFI=N%T=40%C  
OS:D=S)

Uptime guess: 5.583 days (since Thu Dec 26 17:05:53 2024)  
Network Distance: 2 hops  
TCP Sequence Prediction: Difficulty=255 (Good luck!)  
IP ID Sequence Generation: All zeros  
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernelTRACEROUTE (using proto 1/icmp)  
HOP RTT       ADDRESS  
1   102.15 ms 10.21.0.1  
2   99.13 ms  10.10.56.38Read data files from: /usr/share/nmap  
OS and Service detection performed. Please report any incorrect results at [https://nmap.org/submit/](https://nmap.org/submit/) .  
# Nmap done at Wed Jan  1 07:05:36 2025 -- 1 IP address (1 host up) scanned in 37.00 seconds
```
# Discovery

![](https://miro.medium.com/v2/resize:fit:700/1*_FcZki6jmpl0ZrQdhuCifg.png)

![](https://miro.medium.com/v2/resize:fit:503/1*NQElgVaowrsiCMDeQDbSKQ.png)

![](https://miro.medium.com/v2/resize:fit:700/1*oP1EdTjrRuulSr023EskCw.png)

![](https://miro.medium.com/v2/resize:fit:700/1*f5hYNy9RONlE8hj8uCJEjA.png)

![](https://miro.medium.com/v2/resize:fit:700/1*CDfYDgMFBL-VHkoqjwES_Q.png)

# Web Enum
![](https://miro.medium.com/v2/resize:fit:700/1*B4ZpbEpeo5Ii-k1c6Hc1xg.png)

![](https://miro.medium.com/v2/resize:fit:700/1*s9I_hFudNR0nfX9OF7-3XA.png)

![](https://miro.medium.com/v2/resize:fit:700/1*gur4DRptfmlKiVYowSKILg.png)

![](https://miro.medium.com/v2/resize:fit:700/1*YKhdinZWBtBY1QtjmuDh-Q.png)

## Getting Credidentals
![](https://miro.medium.com/v2/resize:fit:700/1*TPeV4ljIbE8zTgxDTjexsA.png)

![](https://miro.medium.com/v2/resize:fit:700/1*pcZHpz1_I4AiYqoP8-puVw.png)

![](https://miro.medium.com/v2/resize:fit:700/1*n8U5h15jRGKKJS9bXpW88g.png)

![](https://miro.medium.com/v2/resize:fit:700/1*yQiagqTofnSgYhBssOY2Tw.png)

## Web Vuln
![](https://miro.medium.com/v2/resize:fit:700/1*sZtSRUlDmubYeur2VoFCDg.png)

![](https://miro.medium.com/v2/resize:fit:636/1*jgDmg3AUC93MmWD8yXcnqQ.png)

# Web Exploit
![](https://miro.medium.com/v2/resize:fit:700/1*N6xz16-qlx_Ee29QNP0YDg.png)

![](https://miro.medium.com/v2/resize:fit:676/1*Zx0RyqC_fmrlQWrWQv3-Vg.png)

![](https://miro.medium.com/v2/resize:fit:675/1*dW8fMXOPJdrOMeR0t8n6wg.png)

# Privilege Esc.
![](https://miro.medium.com/v2/resize:fit:700/1*cQLFx8wKsfpXYgT3ecxxcg.png)

![](https://miro.medium.com/v2/resize:fit:668/1*U-JiCbx_cFT-m3HHXCPC7Q.png)

# References

EJS, Server side template injection ejs@3.1.9 Latest #720, [https://github.com/mde/ejs/issues/720](https://github.com/mde/ejs/issues/720)
