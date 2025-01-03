---
title: Retracted
tags:
  - thm
  - soc
draft: false
aliases:
---

## Task 2 - The Message
![](https://i.hizliresim.com/bqr04ga.jpg)
### What is the full path of the text file containing the "message"?
A: `C:\Users\Sophie\Desktop\SOPHIE.txt`
### What program was used to create the text file? What is the time of execution of the process that created the text file?
![](https://i.hizliresim.com/923izq9.jpg)
After waiting for `Event Viewer` to open for a while, you can go to `Application and Service Logs > Microsoft > Windows > Sysmon > Operational`. 

After opening the logs, filter the logs with `Event ID ` `1` by clicking  `Filter Current Log`.

![Filter Events](https://i.hizliresim.com/jn3ibyu.jpg)After filtering the logs as `Event ID 1`, search for `SOPHIE.txt` by clicking `Find...`.
![enter image description here](https://i.hizliresim.com/36sjdmz.jpg)
![enter image description here](https://i.hizliresim.com/6h7l4xl.jpg)
## Task 3 - Something Wrong
Clear the filter first by clicking `Clear Filter`
### What is the filename of this "installer"? (Including the file extension) What is the download location of this installer?
![enter image description here](https://i.hizliresim.com/8raj0g5.jpg)
### The installer encrypts files and then adds a file extension to the end of the file name. What is this file extension?
![](https://i.hizliresim.com/hsf02dp.jpg)
### The installer reached out to an IP. What is this IP?
![](https://i.hizliresim.com/cl6xt19.jpg)
![](https://i.hizliresim.com/cz0vx0d.jpg)
## Task 4 - Back To Normal
### The threat actor logged in via RDP right after the “installer” was downloaded. What is the source IP? This other person downloaded a file and ran it. When was this file run?  Timezone UTC (Format YYYY-MM-DD hh:mm:ss)
![](https://i.hizliresim.com/ji767ap.jpg)
## Task 5 - Doesn't Make Sense
## Arrange the following events in sequential order from 1 to 7, based on the timeline in which they occurred.
1. Sophie downloaded the malware and ran it.
2. The malware encrypted the files on the computer and showed a ransomware note.
3. Sophie ran out and reached out to you for help.
4. Someone else logged into Sophie's machine via RDP and started looking around.
5. The intruder downloaded a decryptor and decrypted all the files.
6. A note was created on the desktop telling Sophie to check her Bitcoin.
7. We arrive on the scene to investigate.
