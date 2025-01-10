---
title: Instant
tags:
  - htb
  - medium
---

#### Author: **lomar**

---

### HackTheBox: Instant Write-Up 

- T1046: Network Service Scanning
- T1070: Indicator Removal on Host
- T1071: Application Layer Protocol
- T1003: Credential Dumping
- T1552: Unsecured Credentials


![image](https://github.com/user-attachments/assets/fde3eed5-7d41-4a6b-9f68-d07aa72faace)

From the `nmap` scan we can see only` 22` and `80 `ports are open.

![image](https://github.com/user-attachments/assets/03a177cd-c515-4b01-9f0d-6e36f50075d1)

I found a download link for a mobile app. I use `apktool`  and decompiled this file. This revealed the application code and assets, including` smali` files that contain the app's logic.

![image](https://github.com/user-attachments/assets/f39c5658-80b9-4b9b-a1ef-00424118740f)

I focused on` AdminActivities.smali `file likely releated on admin avtivities and there is a hardcoded` JWT` token embedded for admin user. This token could potentially grant unauthorized users access to sensitive administrative functions.

![image](https://github.com/user-attachments/assets/761f961b-41a0-45b2-8be9-a6ee76bf1091)

To successfull set up the environment for testing the APIs you should add the subdomain` swagger-ui.instant.htb` to the `/etc/hosts` file. 

`curl -X GET "http://swagger-ui.instant.htb/api/v1/admin/read/log?log_file_name=..%2F.ssh%2Fid_rsa" -H  "accept: application/json" -H  "Authorization: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwicm9sZSI6IkFkbWluIiwid2FsSWQiOiJmMGVjYTZlNS03ODNhLTQ3MWQtOWQ4Zi0wMTYyY2JjOTAwZGIiLCJleHAiOjMzMjU5MzAzNjU2fQ.v0qyyAqDSgyoNFHU7MgRQcDA0Bw99_8AEXKGtWZ6rYA"`

 Using this command we can successfully extracted the private ssh key.

![image](https://github.com/user-attachments/assets/43aa59c7-0a47-4538-968b-75119333feac)

Setting the correct permissions and connect ssh with this key.

![image](https://github.com/user-attachments/assets/19fac0dd-9870-4244-89fd-b7259217733e)

![image](https://github.com/user-attachments/assets/2266b5b3-4ab6-4a2d-9ac7-286b9c738df2)

I found here a `sql database`, inside usernames and hashed passwords. 

![image](https://github.com/user-attachments/assets/489792b3-37b5-41eb-a63e-6cd2b03f4ad3)

Then I found a .`dat` file. 

![image](https://github.com/user-attachments/assets/c6cfc226-d102-4549-9173-c35da06ed0d0)

We can crack this with `solar putty decrypt tool`. https://github.com/VoidSec/SolarPuttyDecrypt
And finally switch the user with` su root `command and` cat` the flag.
