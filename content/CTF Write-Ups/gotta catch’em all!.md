---
title: Gotta Catch’em All!
tags:
  - thm
  - easy
---
# TryHackMe Gotta Catch’em All! Write-Up


![](https://miro.medium.com/v2/resize:fit:700/1*Eh_QzZyYvbd3JrRQeg0eXA.png)

Deploying the machine and my target ip is **10.10.143.41**

First off all scanning the machine with _nmap_ and I found **22** and **80** ports are open.

![](https://miro.medium.com/v2/resize:fit:700/1*bO4A7r6bg9L0FC8eltnhVQ.png)

Then doing a _gobuster_ scan but nothing interesting.

![](https://miro.medium.com/v2/resize:fit:668/1*krq3L2oHGtNsqgyQlWQzvg.png)

Visit the default page and there is nothing we can do :/

![](https://miro.medium.com/v2/resize:fit:700/1*VQA0OG9t7630mXpUkozXxg.png)

So, take a look the page source and finally found something. It’s probably _ssh_ nickname and password.

![](https://miro.medium.com/v2/resize:fit:504/1*fiehI4-u8zcopbzWVxI-5Q.png)

Yeah it is work!

![](https://miro.medium.com/v2/resize:fit:592/1*BtPvBWf7WbiYZLnyBWAo0g.png)

In desktop there is a _zip_ file. _Unzip_ it and there is the **grass-type pokemon.**

![](https://miro.medium.com/v2/resize:fit:508/1*a1HfZtdFybYK2offh1k0TQ.png)

We can read it with _cat_ command but its encrypted with _hex._

![](https://miro.medium.com/v2/resize:fit:700/1*epU_Jw2kNGwTb2JZnRJvqQ.png)

I deceode it with [**cyberchef**](https://gchq.github.io/CyberChef/) and here is the **grass-type pokemon flag.**

![](https://miro.medium.com/v2/resize:fit:700/1*MnP0adnPLsVS-FLCgaBGhA.png)

I search for the water-type pokemon but i cant see. So search with _locate_ command and here is **txt** file. But its encrypted too.

![](https://miro.medium.com/v2/resize:fit:499/1*YYSxhnVx8zKuuCjhzjUhBw.png)

It’s look like _caesar cipher cryptography algorithm_ so i use [**this**](https://cryptii.com/pipes/caesar-cipher) decoder. And here is the **water-type pokemon flag.**

![](https://miro.medium.com/v2/resize:fit:700/1*3onZ6mKyjrKCgPaFvJpUbg.png)

Then I search other files and in **videos** files I found something.

![](https://miro.medium.com/v2/resize:fit:471/1*PCazzrQwHEHSFTW6I49i9g.png)

There is a password for **ash** user.

![](https://miro.medium.com/v2/resize:fit:700/1*zzyYOZjNc5ckum6G4GHNJA.png)

Check with _sudo -l_ command and we can see **(ALL : ALL) ALL .**

![](https://miro.medium.com/v2/resize:fit:700/1*Vaz5qJu9PWC8Jk8TI5L5MA.png)

This mean is if you type **sudo su**, you can be **_root_** with any password.

![](https://miro.medium.com/v2/resize:fit:529/1*_cgsEdVGsUA7kBKaoOT_Tg.png)

Okay we are root now. Find the fire-type pokemon with _locate_ command. But this file encrypted too :( It’s look like crypted with _base64_ so I use [**cyberchef**](https://gchq.github.io/CyberChef/) again. And here is the **fire-type pokemon flag.**

![](https://miro.medium.com/v2/resize:fit:700/1*holimJuiIV4lll8_L6xsXQ.png)

Finally we can read the **roots favorite pokemon.**

![](https://miro.medium.com/v2/resize:fit:555/1*W_h2wdl2XDTIaThwMEkawA.png)

We are done!!!
