---
title: Chemistry
tags:
  - htb
  - easy
---
#  **HackTheBox: Chemistry Write-Up**

- T1046
- T1203
- T1003

 ## **Discovery**
![nmap](https://github.com/user-attachments/assets/e058cfff-31da-44c5-a6e1-b43d25f7e18a)

From the` nmap `scan we can see only `22 `and` 5000 `ports are open

![image](https://github.com/user-attachments/assets/6c0da427-3992-4288-8624-3eb2ad2bf7b4)

![loginpage](https://github.com/user-attachments/assets/2f2c8d70-0cfd-4efd-8d8c-d57451efae8a)

 I try` brute-force` and` sqli `attacks but nothing so try just register and here is the dashboard.

![dashboard](https://github.com/user-attachments/assets/9ba8dc4d-e0b4-4444-a191-8e937eb8fe36)

Then we see an upload functionality that require a valid `CIF` file. Then click the example file.
![image](https://github.com/user-attachments/assets/529e6b0d-2190-45e7-be5b-e8ba32926f32)

Search for the `cif cve` and I found an exploitation. https://github.com/materialsproject/pymatgen/security/advisories/GHSA-vgv8-5cpj-qj2f  
I change the cif file and upload the system and starting` netcat listener`.

![cifdosyasi](https://github.com/user-attachments/assets/d0753947-88fa-47d3-a85d-55f22669a7b4)

![image](https://github.com/user-attachments/assets/247f1a74-c14e-4df4-99e8-514df04c589a)
Then click view and trigger the file for reverse shell.

![nclistener](https://github.com/user-attachments/assets/0043c4b6-fe60-4eda-b339-bffcea7391b9)

![image](https://github.com/user-attachments/assets/a8afdd23-109e-4d49-bce6-0a81157d07dd)

![image](https://github.com/user-attachments/assets/245cdc39-43d6-40b7-9008-35cfcf9a2de6)

There is a `database` file that contain credentials of users, also credentials for `rosa` were inside it.
After cracking the hash with` hashcat ` we can log in ssh as rosa.

![hashcat](https://github.com/user-attachments/assets/ab908b85-0399-4060-9eb7-f6acfbe74dd9)

![rosassh](https://github.com/user-attachments/assets/b611f0c9-e022-41b5-afea-e3e584a4fcf5)

Okay here is the` user flag.`
![image](https://github.com/user-attachments/assets/5ebbaf80-3d32-4221-93c7-8a894447d128)

Then for root flag I try the` sudo-l `command but nothing.

![rosasudo](https://github.com/user-attachments/assets/a60a0e5a-132a-459c-bfdd-dc99436634d9)

Use` netstat -l` to see what else we have up on the machine. On `8080  `it looks like there is some website.

![netstat](https://github.com/user-attachments/assets/362ae3c5-be08-405b-aedb-43a99425ddba)

Then I try the request.
![curllocalhost](https://github.com/user-attachments/assets/9f6d0f84-90f2-4449-94ab-8741b634f611)

![aiohttp](https://github.com/user-attachments/assets/95a50cb7-c66a-42b1-87f7-53507ebd6771)

I saw` aiohttp` then a google search, there is` CVE `related to the server version.
![cve_2024_23334](https://github.com/user-attachments/assets/2042ba9b-a866-4797-bc52-062600bdf445)

So, we can read files by exploiting path traversal. Here you can read the `root flag.`
![curletcroot](https://github.com/user-attachments/assets/955c3c2a-3842-4932-905c-ca09e104a803)