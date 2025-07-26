---
title: UltraTech
tags:
  - thm
  - medium
---

#### Author: AMD

![[static/ultra_tech/ultra_tech.png]]

This is a writeup for <b>UltraTech</b> room.

-----------------------------------------------------------------------------------
<b>NMAP</b>

![[static/ultra_tech/nmap.png]]

With this result we can answer "Which other non-standard port is used?"

-----------------------------------------------------------------------------------
<b>Which software is using the port 8081?</b>

![[static/ultra_tech/nmap_8081.png]]

-----------------------------------------------------------------------------------
<b>Which software using this port?</b>

![[static/ultra_tech/nmap_31331.png]]

-----------------------------------------------------------------------------------
<b>Which GNU/Linux distribution seems to be used?</b>

![[static/ultra_tech/nmap_os.png]]

-----------------------------------------------------------------------------------
<b>The software using the port 8081 is a REST api, how many of its routes are used by the web application?</b>

![[static/ultra_tech/api_route_count.png]]

-----------------------------------------------------------------------------------
<b>PREPARATION</b>

"Did you find somewhere you could try to login?" --> Lets find it

Lets try ffuf on 31331

![[static/ultra_tech/ffuf.png]]

Lets checkout robots.txt

![[static/ultra_tech/robots_txt.png]]

Lets check out utech_sitemap.txt

![[static/ultra_tech/utech_sitemap.png]]

Lets checkout partners.html

![[static/ultra_tech/partners_html.png]]

We found the login

-----------------------------------------------------------------------------------
<b>There is a database lying around, what is its filename?</b>

Lets catch the login request with burp

![[static/ultra_tech/burp_login.png]]

The hint says /auth is not alone. When we view the page source we can find out that there is a api.js

If we click on it we can find the other endpoint

![[static/ultra_tech/api_js.png]]

Lets use curl

![[static/ultra_tech/ping.png]]

Perfect. Now we can try to run some commands

![[static/ultra_tech/db.png]]

-----------------------------------------------------------------------------------
<b>What is the first user's password hash?</b>

Lets use cat

![[static/ultra_tech/cat_hashes.png]]

-----------------------------------------------------------------------------------
<b>What is the password associated with this hash?</b>

Lets use https://crackstation.net/

![[static/ultra_tech/crackstation_root.png]]

-----------------------------------------------------------------------------------
<b>What are the first 9 characters of the root user's private SSH key?</b>

Lets ssh r00t

![[static/ultra_tech/ssh.png]]

![[static/ultra_tech/try_ssh_key.png]]

Unfortunately we are not really root. Lets try privilege esclation.

![[static/ultra_tech/perms.png]]

We will focus on pkexec. Lets find vulnerability

![[static/ultra_tech/google_search.png]]

Lets set it up

![[static/ultra_tech/our_device.png]]

Lets downlaod it to the machine and give execution rights.

![[static/ultra_tech/machine.png]]

Everything is ready, lets run it.

![[static/ultra_tech/run_pwn_kit.png]]

Perfect, we are in. Lets get the key

![[static/ultra_tech/get_the_key.png]]







