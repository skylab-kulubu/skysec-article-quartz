---
title: Startup
tags:
  - thm 
  - easy
---
# TryHackMe|Startup Write-Up

Deploying the machine and my target ip is  _10.10.102.128_

First,scanning the machine with  **nmap**  and I found  _21,22_  and  _80_  ports are open.

![](https://miro.medium.com/v2/resize:fit:835/1*cHDayFW3SS9EaJ6OPh0tGw.png)

So I take a look  **ftp.**

![](https://miro.medium.com/v2/resize:fit:735/1*II80DV_FZ5IocsTQpf2jvA.png)

Then I browse the ip adres, seems clear.

![](https://miro.medium.com/v2/resize:fit:875/1*TBR9gRsow3W2ik1J4JnWDA.png)

Then scanning the adress with **gobuster**  and found  _/files_  directory.

![](https://miro.medium.com/v2/resize:fit:835/1*X4Ad8t2Ns_t5WgsQ32wnpg.png)

![](https://miro.medium.com/v2/resize:fit:779/1*pVmlBpGUtOjFDiVgNwMROA.png)

![](https://miro.medium.com/v2/resize:fit:875/1*-jDu6OfiZLNbTdPcJ-m_sg.png)

:D Okay, there is a **ftp**  directory, so i think i can upload a **shell**. I try _php reverse shell_ and yeah it works.

![](https://miro.medium.com/v2/resize:fit:675/1*7fJjPdA7IIAhzRO1bDn_yA.png)

![](https://miro.medium.com/v2/resize:fit:693/1*_dF-SiI1rKNxAQEfeWWgfQ.png)

Start a **netcat**, then trigger the reverse shell. And we are in!

![](https://miro.medium.com/v2/resize:fit:841/1*I9mohAyUuVOWtrCihTZjlA.png)

Here is the recipe and first question answer;

![](https://miro.medium.com/v2/resize:fit:875/1*MpSrjco1O6BZrAJcdGjZiA.png)

> **_What is the secret spicy soup recipe?_**

**_love_**

Then a little search in the machine and found a **pcap**  file.

![](https://miro.medium.com/v2/resize:fit:604/1*9gkHvdDe6ra9oaQ0W1fBsA.png)

![](https://miro.medium.com/v2/resize:fit:734/1*DGzjKdsdrl2dTCMyVEHYmg.png)

![](https://miro.medium.com/v2/resize:fit:875/1*h0IG72eObxBRDhUmW7mc8g.png)

I found the  _ssh username and password_.

![](https://miro.medium.com/v2/resize:fit:875/1*3nneScS2kW6hEE0anhNIvQ.png)

Here is the  **user flag**;

![](https://miro.medium.com/v2/resize:fit:801/1*FynY1h5aF7KEdmIAT7oOng.png)

Then I take a look other files. There are **planner.sh**  and  **startup_list.txt** files inside the  **scripts** directory. **planner.sh**  file triggers a file named **print.sh**  it’s printing ‘Done!’ .

![](https://miro.medium.com/v2/resize:fit:545/1*5O4vDxMG64C4jZWilCM8eQ.png)

I go the **print.sh**  and using  [**_these_**](https://pentestmonkey.net/cheat-sheet/shells/reverse-shell-cheat-sheet)  payload so I can be root.

![](https://miro.medium.com/v2/resize:fit:801/1*BVXxuekXZNWIToeHKh8M6w.png)

Started a **netcat**  and then trigger the payload. Finally here is the  **_root flag_**;

![](https://miro.medium.com/v2/resize:fit:808/1*H5-44XVJWNJUZ70T3B9-aA.png)
