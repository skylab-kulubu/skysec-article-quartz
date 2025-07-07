---
title: Nocturnal
tags:
  - htb
  - easy
---

#### Author: AMD

![[static/nocturnal/nocturnal.png]]

This is a writeup for <b>Nocturnal</b> machine.

My target IP: 10.10.11.64

-----------------------------------------------------------------------------------
<b>NMAP</b>

Lets scan out target.

![[static/nocturnal/nmap.png]]

-----------------------------------------------------------------------------------
<b>CURL</b>

![[static/nocturnal/curl.png]]

Add "10.10.11.64   nocturnal.htb" to /etc/hosts

-----------------------------------------------------------------------------------
<b>GOBUSTER</b>

![[static/nocturnal/gobuster.png]]

we can not access these urls

-----------------------------------------------------------------------------------
<b>WEBSITE INSPECTION</b>

![[static/nocturnal/website.png]]

First register then login

-----------------------------------------------------------------------------------
<b>TEST FILE UPLOAD</b>

Test file upload with .php file

See the valid file types

Upload valid file and see the link

![[static/nocturnal/file_link.png]]

-----------------------------------------------------------------------------------
<b>FIND OTHER USERS</b>

Lets try to find the other users and use the file link to access other users files.

use https://github.com/C0euss/Nocturnal-Username-Enumeration/tree/main to find other usernames

![[static/nocturnal/enumeration.png]]

-----------------------------------------------------------------------------------
<b>GUESS FILE NAMES</b>

![[static/nocturnal/amandas_file.png]]

http://nocturnal.htb/view.php?username=amanda&file=privacy.odt

-----------------------------------------------------------------------------------
<b>VIEW FILE</b>

![[static/nocturnal/amanda_password.png]]

login with amanda and password

-----------------------------------------------------------------------------------
<b>VIEW PAGES</b>

![[static/nocturnal/amandas_page.png]]

go to admin panel

![[static/nocturnal/admin_panel.png]]

-----------------------------------------------------------------------------------
<b>VIEW LOGIN.PHP</b>

![[static/nocturnal/login_php.png]]

Get db information

-----------------------------------------------------------------------------------
<b>RCE</b>

Enter "dummy" to create backup password field, catch the request with burpsuite and send it to repeater.

url CyberChef to url encode

![[static/nocturnal/cyber_chef.png]]

send with repeater

![[static/nocturnal/burp.png]]

-----------------------------------------------------------------------------------
<b>SSH</b>

Crack tobias's password using https://crackstation.net/

![[static/nocturnal/crackstation.png]]

connect with ssh

![[static/nocturnal/ssh.png]]

-----------------------------------------------------------------------------------
<b>GET USER FLAG</b>

![[static/nocturnal/user_txt.png]]

-----------------------------------------------------------------------------------
<b>NETSTAT</b>

Use netstat to use what is working on the machine

![[static/nocturnal/netstat.png]]

-----------------------------------------------------------------------------------
<b>PF</b>

We cannot visit http://127.0.0.1:8080 so lets try port forwarding

![[static/nocturnal/pf1.png]]

![[static/nocturnal/pf2.png]]

Lets visit http://127.0.0.1:8080

![[static/nocturnal/isp_login.png]]

-----------------------------------------------------------------------------------
<b>LOGIN</b>

Lets try to login with tobias's credentials --> doesnt work

Lets try other usernames we found (amanda, admin)  --> admin works

![[static/nocturnal/isp_home.png]]

-----------------------------------------------------------------------------------
<b>EXEMINE SITE</b>

![[static/nocturnal/isp.png]]

Lets find vulnerability for this version ISPConfig 

![[static/nocturnal/isp_volnurability_search.png]]

![[static/nocturnal/code.png]]

-----------------------------------------------------------------------------------
<b>EXPLOIT VULNURABILITY</b>

run "nano CVE-2023-46818.py"  --> paste the code  --> save and exit

![[static/nocturnal/run_exploit.png]]

-----------------------------------------------------------------------------------
<b>GET ROOT FLAG</b>

![[static/nocturnal/flag.png]]
