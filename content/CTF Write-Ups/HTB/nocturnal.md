---
title: Nocturnal
tags:
  - htb
  - easy
---

#### Author: AMD

![nocturnal](https://github.com/user-attachments/assets/bcf92479-9d55-48f6-a797-94aad3554887)

This is a writeup for <b>Nocturnal</b> machine.

My target IP: 10.10.11.64

-----------------------------------------------------------------------------------
<b>NMAP</b>

Lets scan out target.

![nmap](https://github.com/user-attachments/assets/d27e4197-0e89-45db-94b7-0b3850989974)

-----------------------------------------------------------------------------------
<b>CURL</b>

![curl](https://github.com/user-attachments/assets/84083116-5dc2-401c-9b3d-1051d13f87a5)

Add "10.10.11.64   nocturnal.htb" to /etc/hosts

-----------------------------------------------------------------------------------
<b>GOBUSTER</b>

![gobuster](https://github.com/user-attachments/assets/7456f1e3-1046-4143-b468-492de31c3f71)

we can not access these urls

-----------------------------------------------------------------------------------
<b>WEBSITE INSPECTION</b>

![website](https://github.com/user-attachments/assets/a763e131-020e-4e86-b730-e308940348c7)

First register then login

-----------------------------------------------------------------------------------
<b>TEST FILE UPLOAD</b>

Test file upload with .php file

See the valid file types

Upload valid file and see the link

![file_link](https://github.com/user-attachments/assets/acab27ae-2c89-41bd-b28f-f03e3d72a3f0)

-----------------------------------------------------------------------------------
<b>FIND OTHER USERS</b>

Lets try to find the other users and use the file link to access other users files.

use https://github.com/C0euss/Nocturnal-Username-Enumeration/tree/main to find other usernames

![enumeration](https://github.com/user-attachments/assets/412da53f-c423-40f3-8077-1fb6cf1af18d)

-----------------------------------------------------------------------------------
<b>GUESS FILE NAMES</b>

![amandas_file](https://github.com/user-attachments/assets/fc117214-ea13-4880-babf-f2d03ea9690e)

http://nocturnal.htb/view.php?username=amanda&file=privacy.odt

-----------------------------------------------------------------------------------
<b>VIEW FILE</b>

![amanda_password](https://github.com/user-attachments/assets/9c9705f7-4e61-4086-83c0-0677ee926d4a)

login with amanda and password

-----------------------------------------------------------------------------------
<b>VIEW PAGES</b>

![amandas_page](https://github.com/user-attachments/assets/3667cb9e-a5b1-44a5-a77f-556ae86984c0)

go to admin panel

![admin_panel](https://github.com/user-attachments/assets/85d630e3-93eb-4b7b-ae5c-15dab7012d9e)

-----------------------------------------------------------------------------------
<b>VIEW LOGIN.PHP</b>

![login php](https://github.com/user-attachments/assets/693e99c6-6af6-4c2a-bb9a-45bd04da3586)

Get db information

-----------------------------------------------------------------------------------
<b>RCE</b>

Enter "dummy" to create backup password field, catch the request with burpsuite and send it to repeater.

url CyberChef to url encode

![cyber_chef](https://github.com/user-attachments/assets/c61146db-93b8-4cbd-9d12-b60cbf3d4872)

send with repeater

![burp](https://github.com/user-attachments/assets/4b12940d-6186-49f8-acd6-6e344449da4f)

-----------------------------------------------------------------------------------
<b>SSH</b>

Crack tobias's password using https://crackstation.net/

![crackstation](https://github.com/user-attachments/assets/ffc145a0-a301-44ee-9100-86871a30ae06)

connect with ssh

![ssh](https://github.com/user-attachments/assets/7c69f9e6-4725-4843-bf42-ef92db0e9661)

-----------------------------------------------------------------------------------
<b>GET USER FLAG</b>

![user_txt](https://github.com/user-attachments/assets/05d86c68-976f-4f79-a353-5d9461a40266)

-----------------------------------------------------------------------------------
<b>NETSTAT</b>

Use netstat to use what is working on the machine

![netstat](https://github.com/user-attachments/assets/ee1b0efe-f07d-4ca3-beb3-980fe8219323)

-----------------------------------------------------------------------------------
<b>PF</b>

We cannot visit http://127.0.0.1:8080 so lets try port forwarding

![pf1](https://github.com/user-attachments/assets/e6e63281-8893-4138-848a-4a50c7af6d5e)

![pf2](https://github.com/user-attachments/assets/d9e9e0c4-fd59-4f99-818d-290d25c38581)

Lets visit http://127.0.0.1:8080

![isp_login](https://github.com/user-attachments/assets/1bc9e902-2462-414e-b8f3-e9d917e03881)

-----------------------------------------------------------------------------------
<b>LOGIN</b>

Lets try to login with tobias's credentials --> doesnt work

Lets try other usernames we found (amanda, admin)  --> admin works

![isp_home](https://github.com/user-attachments/assets/d26fca90-ef10-46ae-8de9-b7888a61546d)

-----------------------------------------------------------------------------------
<b>EXEMINE SITE</b>

![isp](https://github.com/user-attachments/assets/ce1bf880-7a11-4220-bc93-12427fcd193e)

Lets find vulnerability for this version ISPConfig 

![isp_volnurability_search](https://github.com/user-attachments/assets/c0516e2c-4c28-4c64-8f18-9f57feae89ec)

![code](https://github.com/user-attachments/assets/6600536d-0dab-46d3-ba27-036d982a837c)

-----------------------------------------------------------------------------------
<b>EXPLOIT VULNURABILITY</b>

run "nano CVE-2023-46818.py"  --> paste the code  --> save and exit

![run_exploit](https://github.com/user-attachments/assets/afdda0e2-e73a-4a6d-8b3b-ff1fb266225e)

-----------------------------------------------------------------------------------
<b>GET ROOT FLAG</b>

![flag](https://github.com/user-attachments/assets/993642f5-19e5-4c25-b85a-5bd6379943f4)
