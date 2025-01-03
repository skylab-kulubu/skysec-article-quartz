---
title: Bounty Hacker
tags:
  - thm
  - easy
---
![image](https://github.com/user-attachments/assets/5a76a502-1bed-4e0f-b9e6-10f29dfcd92b)

This is a writeup for <b>Bounty Hacker</b> room.

My target IP: 10.10.228.252

-----------------------------------------------------------------------------------
 
<b>NMAP</b>

Lets scan out target and check for open ports.

![image](https://github.com/user-attachments/assets/56fe0daf-e3c1-4fc0-a580-a4a743e02671)

3 ports are open.

-----------------------------------------------------------------------------------

<b>GOBUSTER</b>

![image](https://github.com/user-attachments/assets/30bf4985-f188-4601-a88a-3b58d23bd899)

Seems like website does not have much unusual stuff.

-----------------------------------------------------------------------------------

<b>WEBSITE INSPECTION</b>

There is not much going on with the website and images directory. I checked the page source and it was clean.

![image](https://github.com/user-attachments/assets/e8e37ecd-833b-48fe-90a2-f6dbec032be3)

-----------------------------------------------------------------------------------

<b>FTP</b>

We can try if FTP allows us to login anonymously.

![image](https://github.com/user-attachments/assets/e46ceada-93b6-42b6-9b2f-8ccd8e2dc77a)

We managed to login successfully. I found 2 files and transferred them to my machine.

![image](https://github.com/user-attachments/assets/a6bc837f-f5f6-4215-9864-7f7cb6182b24)

Locks file contains some passwords and there is a task file that contains one of the questions answer which is the name of the writer.

![image](https://github.com/user-attachments/assets/6b8d6a83-e881-4dc9-9d35-cbb04b7af4cf)

![image](https://github.com/user-attachments/assets/67198025-8812-4b5b-90ba-5c7606440f56)

-----------------------------------------------------------------------------------

<b>SSH</b>

We can try bruteforcing ssh. I assume the username is the one we found in the task.txt.

``hydra -l USERNAME -P locks.txt 10.10.228.252 ssh``

![image](https://github.com/user-attachments/assets/6c73d88e-f10a-45ec-810b-0b2170656aa4)

We have the password. Now lets login.

![image](https://github.com/user-attachments/assets/c13ecc38-3303-433b-bc97-78e59cf4c6bb)

-----------------------------------------------------------------------------------

<b>USER FLAG</b>

I will search for the user flag. This time it was at our directory but you can go to / directory and use “find -name user.txt” command.

![image](https://github.com/user-attachments/assets/5925fa83-0a2c-4d97-b3b0-7274cb2f8257)

-----------------------------------------------------------------------------------

<b>ROOT FLAG</b>

First I will start by checking what commands we can run.

We can run /bin/tar. I will check gtfobins for possible exploits.

https://gtfobins.github.io/gtfobins/tar/?source=post_page-----fde6b61b8290--------------------------------

I will try this one:

``sudo tar -cf /dev/null /dev/null --checkpoint=1 --checkpoint-action=exec=/bin/sh``

![image](https://github.com/user-attachments/assets/b1cba6e4-fc86-4f7a-8a18-a9ae2bfe4f05)

It worked and now we have root acces. Now we can get the root flag.

![image](https://github.com/user-attachments/assets/6fd150ce-f3b9-40c3-92f6-e8036bcebc9c)