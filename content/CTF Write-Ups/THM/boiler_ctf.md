---
title: Boiler CTF
tags:
  - thm
  - medium
---

#### Author: AMD

![[static/boiler_ctf/boiler_ctf.png]]

This is a writeup for <b>Boiler CTF</b> room.

-----------------------------------------------------------------------------------
<b>NMAP</b>

Lets scan the target ip.

![[static/boiler_ctf/nmap.png]]

-----------------------------------------------------------------------------------
<b>File extension after anon login?</b>

![[static/boiler_ctf/q1.png]]

-----------------------------------------------------------------------------------
<b>What is on the highest port?</b>

![[static/boiler_ctf/q2.png]]

It is ssh.

-----------------------------------------------------------------------------------
<b>What's running on port 10000?</b>

![[static/boiler_ctf/q3_research.png]]

![[static/boiler_ctf/q3.png]]

It is webmin

-----------------------------------------------------------------------------------
<b>Can you exploit the service running on that port?</b>

The version is not on the login page or on the page source. Lets try curl.

![[static/boiler_ctf/q4_version.png]]

Lets go to https://www.exploit-db.com/ and search webmin.

![[static/boiler_ctf/q4_research.png]]

No public unauthenticated RCE, LFI, or CSRF exists for Webmin 1.930. So answer is nay.

-----------------------------------------------------------------------------------
<b>What's CMS can you access?</b>

Lets use gobustor to look.

![[static/boiler_ctf/q5_gobuster.png]]

The answer is joomla.

-----------------------------------------------------------------------------------
<b>Keep enumerating, you'll know when you find it.</b>

![[static/boiler_ctf/q6_gobuster.png]]

_files look weird, lets check it out. After decoding the message it comes to "Whopsie daisy". 

Lets try it with bigger data.

![[static/boiler_ctf/q6_gobuster_2.png]]

Perfect, we got new ones. _database and _test is weird too.

-----------------------------------------------------------------------------------
<b>The interesting file name in the folder?</b>

_database gives us "Lwuv oguukpi ctqwpf. " which is "J u s t   m e s s i n g   a r o u n d ." with Caesar cipher.

![[static/boiler_ctf/q7_test_page.png]]

We can see that if we change the plot on the url it reflect to page. So lets try running a command.

I tried ls, it didn't worked but ;ls works.

![[static/boiler_ctf/q7.png]]

I guess log.txt is weird.

-----------------------------------------------------------------------------------
<b>PREPERATION</b>

Lets get in.

![[static/boiler_ctf/prep_cat.png]]

We found username and password.

![[static/boiler_ctf/prep_ssh.png]]

-----------------------------------------------------------------------------------
<b>Where was the other users pass stored(no extension, just the name)?</b>

![[static/boiler_ctf/q8.png]]

It is in backup.sh

-----------------------------------------------------------------------------------
<b>user.txt</b>

Lets ssh stoner.

![[static/boiler_ctf/q9_ssh.png]]

I looked for user.txt, it wasn't there but we have .secret

![[static/boiler_ctf/q9.png]]

-----------------------------------------------------------------------------------
<b>What did you exploit to get the privileged user?</b>

Lets search the system for regular files with the setuid bit set.

![[static/boiler_ctf/q10_research.png]]

/find looks weird. (Note: You can use GPT to locate whats unusual)

Lets visit https://gtfobins.github.io/ to look for find.

![[static/boiler_ctf/q10_find.png]]

![[static/boiler_ctf/q10_exploit.png]]

We used find to become root.

-----------------------------------------------------------------------------------
<b>root.txt</b>

![[static/boiler_ctf/q11.png]]