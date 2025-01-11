---
title: Silver Platter
tags:
  - easy
  - thm
---
#### Author: lomar

---

# Nmap Scan

```plaintext
# Nmap 7.95 scan initiated Sat Jan 11 04:33:52 2025 as: /usr/lib/nmap/nmap -sT -A -v -oA nmap 10.10.83.11
Nmap scan report for 10.10.83.11
Host is up (0.075s latency).
Not shown: 997 closed tcp ports (conn-refused)
PORT     STATE SERVICE    VERSION
22/tcp   open  ssh        OpenSSH 8.9p1 Ubuntu 3ubuntu0.4 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   256 1b:1c:87:8a:fe:34:16:c9:f7:82:37:2b:10:8f:8b:f1 (ECDSA)
|_  256 26:6d:17:ed:83:9e:4f:2d:f6:cd:53:17:c8:80:3d:09 (ED25519)
80/tcp   open  http       nginx 1.18.0 (Ubuntu)
|_http-title: Hack Smarter Security
| http-methods: 
|_  Supported Methods: GET HEAD
|_http-server-header: nginx/1.18.0 (Ubuntu)
8080/tcp open  http-proxy
|_http-title: Error
| fingerprint-strings: 
|   FourOhFourRequest, GetRequest, HTTPOptions: 
|     HTTP/1.1 404 Not Found
|     Connection: close
|     Content-Length: 74
|     Content-Type: text/html
|     Date: Sat, 11 Jan 2025 09:34:00 GMT
|     <html><head><title>Error</title></head><body>404 - Not Found</body></html>
|   GenericLines, Help, Kerberos, LDAPSearchReq, LPDString, RTSPRequest, SMBProgNeg, SSLSessionReq, Socks5, TLSSessionReq, TerminalServerCookie: 
|     HTTP/1.1 400 Bad Request
|     Content-Length: 0
|_    Connection: close
1 service unrecognized despite returning data. If you know the service/version, please submit the following fingerprint at https://nmap.org/cgi-bin/submit.cgi?new-service :
SF-Port8080-TCP:V=7.95%I=7%D=1/11%Time=67823B08%P=x86_64-pc-linux-gnu%r(Ge
SF:tRequest,C9,"HTTP/1\.1\x20404\x20Not\x20Found\r\nConnection:\x20close\r
SF:\nContent-Length:\x2074\r\nContent-Type:\x20text/html\r\nDate:\x20Sat,\
SF:x2011\x20Jan\x202025\x2009:34:00\x20GMT\r\n\r\n<html><head><title>Error
SF:</title></head><body>404\x20-\x20Not\x20Found</body></html>")%r(HTTPOpt
SF:ions,C9,"HTTP/1\.1\x20404\x20Not\x20Found\r\nConnection:\x20close\r\nCo
SF:ntent-Length:\x2074\r\nContent-Type:\x20text/html\r\nDate:\x20Sat,\x201
SF:1\x20Jan\x202025\x2009:34:00\x20GMT\r\n\r\n<html><head><title>Error</ti
SF:tle></head><body>404\x20-\x20Not\x20Found</body></html>")%r(RTSPRequest
SF:,42,"HTTP/1\.1\x20400\x20Bad\x20Request\r\nContent-Length:\x200\r\nConn
SF:ection:\x20close\r\n\r\n")%r(FourOhFourRequest,C9,"HTTP/1\.1\x20404\x20
SF:Not\x20Found\r\nConnection:\x20close\r\nContent-Length:\x2074\r\nConten
SF:t-Type:\x20text/html\r\nDate:\x20Sat,\x2011\x20Jan\x202025\x2009:34:00\
SF:x20GMT\r\n\r\n<html><head><title>Error</title></head><body>404\x20-\x20
SF:Not\x20Found</body></html>")%r(Socks5,42,"HTTP/1\.1\x20400\x20Bad\x20Re
SF:quest\r\nContent-Length:\x200\r\nConnection:\x20close\r\n\r\n")%r(Gener
SF:icLines,42,"HTTP/1\.1\x20400\x20Bad\x20Request\r\nContent-Length:\x200\
SF:r\nConnection:\x20close\r\n\r\n")%r(Help,42,"HTTP/1\.1\x20400\x20Bad\x2
SF:0Request\r\nContent-Length:\x200\r\nConnection:\x20close\r\n\r\n")%r(SS
SF:LSessionReq,42,"HTTP/1\.1\x20400\x20Bad\x20Request\r\nContent-Length:\x
SF:200\r\nConnection:\x20close\r\n\r\n")%r(TerminalServerCookie,42,"HTTP/1
SF:\.1\x20400\x20Bad\x20Request\r\nContent-Length:\x200\r\nConnection:\x20
SF:close\r\n\r\n")%r(TLSSessionReq,42,"HTTP/1\.1\x20400\x20Bad\x20Request\
SF:r\nContent-Length:\x200\r\nConnection:\x20close\r\n\r\n")%r(Kerberos,42
SF:,"HTTP/1\.1\x20400\x20Bad\x20Request\r\nContent-Length:\x200\r\nConnect
SF:ion:\x20close\r\n\r\n")%r(SMBProgNeg,42,"HTTP/1\.1\x20400\x20Bad\x20Req
SF:uest\r\nContent-Length:\x200\r\nConnection:\x20close\r\n\r\n")%r(LPDStr
SF:ing,42,"HTTP/1\.1\x20400\x20Bad\x20Request\r\nContent-Length:\x200\r\nC
SF:onnection:\x20close\r\n\r\n")%r(LDAPSearchReq,42,"HTTP/1\.1\x20400\x20B
SF:ad\x20Request\r\nContent-Length:\x200\r\nConnection:\x20close\r\n\r\n");
Device type: general purpose
Running: Linux 4.X
OS CPE: cpe:/o:linux:linux_kernel:4.15
OS details: Linux 4.15
Uptime guess: 0.753 days (since Fri Jan 10 10:30:28 2025)
Network Distance: 2 hops
TCP Sequence Prediction: Difficulty=260 (Good luck!)
IP ID Sequence Generation: All zeros
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

TRACEROUTE (using proto 1/icmp)
HOP RTT      ADDRESS
1   75.03 ms 10.21.0.1
2   75.33 ms 10.10.83.11

Read data files from: /usr/share/nmap
OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
# Nmap done at Sat Jan 11 04:35:24 2025 -- 1 IP address (1 host up) scanned in 91.27 seconds
```

# Discovery

  Command line : `ffuf -u http://10.10.83.11/FUZZ -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -e html,txt -t 50 -o ffuf.md -of md`

  | FUZZ | URL | Redirectlocation | Position | Status Code | Content Length | Content Words | Content Lines | Content Type | Duration | ResultFile | ScraperData | Ffufhash
  | :- | :-- | :--------------- | :---- | :------- | :---------- | :------------- | :------------ | :--------- | :----------- | :------------ | :-------- |
  | assets | http://10.10.83.11/assets | http://10.10.83.11/assets/ | 871 | 301 | 178 | 6 | 8 | text/html | 117.970341ms |  |  | 2e0c5367
  |  | http://10.10.83.11/ |  | 135718 | 200 | 14124 | 926 | 346 | text/html | 81.640831ms |  |  | 2e0c521226



  Command line : `ffuf -u http://10.10.83.11:8080/FUZZ/ -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -t 40 -o ffuf.md -of md`
  Time: 2025-01-11T05:04:01-05:00

  | FUZZ | URL | Redirectlocation | Position | Status Code | Content Length | Content Words | Content Lines | Content Type | Duration | ResultFile | ScraperData | Ffufhash
  | :- | :-- | :--------------- | :---- | :------- | :---------- | :------------- | :------------ | :--------- | :----------- | :------------ | :-------- |
  |  | http://10.10.83.11:8080/website |  | 45240 | 403 | 68 | 1 | 1 | text/html;charset=UTF-8 | 74.091558ms |  |  | b9bf3b0b8
  |  | http://10.10.83.11:8080/console |  | 45240 | 301 | 68 | 1 | 1 | text/html;charset=UTF-8 | 74.091558ms |  |  | b9bf3b0b8  


![[/static/silverplatter/ksnip_20250111-164628.png]]

![[/static/silverplatter/ksnip_20250111-164650.png]]
![[/static/silverplatter/ksnip_20250111-164707.png]]
# User
Search the software name with `CVE`
![[/static/silverplatter/ksnip_20250111-164715.png]]
If you search the references in this Github post you can find the CVE disclosure. Then login as `scr1ptkiddy`. In the Contact section we can find information about other users.

![[/static/silverplatter/ksnip_20250111-164818.png]]![[/static/silverplatter/ksnip_20250111-164838.png]]
Now let's log in as the `Manager` user. If we try to log in as Administrateur, it says that a technical error occurred.

![[/static/silverplatter/ksnip_20250111-164848.png]]

After logging in as Manager, we notice that there is a message about `SSH` among the notifications that come in. We can look at the messages in more detail.

![[/static/silverplatter/ksnip_20250111-164904.png]]

The administrator user sent us the password for the user `tim`.
![[/static/silverplatter/ksnip_20250111-164918.png]]
With `SSH` we can log in using this information.
![[/static/silverplatter/ksnip_20250111-164956.png]]


# Root

```bash
tim@silver-platter:~$ id
uid=1001(tim) gid=1001(tim) groups=1001(tim),4(adm)
```

```bash
tim@silver-platter:~$ find / -type f -readable 2>/dev/null
```

When you check the file paths, you can see `tim` user can read the logs. 


```bash
tim@silver-platter:~$ grep -i tyler -r /var/log/
```


```plaintext
---TRIM---
/var/log/auth.log.2:Dec 13 15:45:57 silver-platter sudo:    tyler : TTY=tty1 ; PWD=/ ; USER=root ; COMMAND=/usr/bin/docker run --name silverpeas -p 8080:8000 -d -e DB_NAME=Silverpeas -e DB_USER=silverpeas -e DB_PASSWORD=CENCORED_PASSWORD/ -v silverpeas-log:/opt/silverpeas/log -v silverpeas-data:/opt/silvepeas/data --link postgresql:database silverpeas:6.3.1
---TRIM---
```

`/var/log/auth.log.2` file has the user `tyler`s password.
```bash
tyler@silver-platter:~$ sudo -l
Matching Defaults entries for tyler on silver-platter:
    env_reset, mail_badpass, secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/snap/bin, use_pty

User tyler may run the following commands on silver-platter:
    (ALL : ALL) ALL
```

```bash
tyler@silver-platter:~$ sudo cat /root/root.txt|cut -c -10
THM{098f6b
```