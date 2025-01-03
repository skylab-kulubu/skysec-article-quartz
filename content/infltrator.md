---
title: Infltrator
tags:
  - insane
  - htb
---

# User

## Discovery

![](https://miro.medium.com/v2/resize:fit:700/1*grcJQPYefCWs0ZWzsNj-og.png)

![](https://miro.medium.com/v2/resize:fit:700/1*LK9CyyyiqQtkRfXJ5kN3Kg.png)

![](https://miro.medium.com/v2/resize:fit:700/1*hXqKpdT-TQUuI51BuuJJTQ.png)

![](https://miro.medium.com/v2/resize:fit:700/1*aFrt_Glhq6sHlrkyeP8o-A.png)

We cannot obtain any information by scanning the website with tools such  
as gobuster etc. But the content of the website gives us some clues.  
David Anderson, Olivia Martinez, Kevin Turner, Amanda Walker, Marcus  
Harris, Lauren Clark and Ethan Rodriguez are the main employees of this  
company.

Based on the Nmap scan, these users must have accounts connected to the  
Domain Controller.

We can perform an automatic scan by making a wordlist that will scan  
these users.

![](https://miro.medium.com/v2/resize:fit:700/1*GG7fOGca7TEL06Z0NwwEbA.png)

Target people and domain are known, user accounts can be  
name.surname@infiltrator.htb or n.surname@infiltrator.htb.

Enum4linux couldn’t find anything useful, however kerbrute found the  
users.

![](https://miro.medium.com/v2/resize:fit:582/1*yE97HMf9DJ8hJUnu64cIKA.png)

![](https://miro.medium.com/v2/resize:fit:448/1*uYI3KGGMhiGERxb3UJKuvA.png)

![](https://miro.medium.com/v2/resize:fit:700/1*a3VHqKwCwQB64GqiKfs6dg.png)

When a brute force attack is performed on users other than l.clark user,  
“Invalid Password” is output while l.clark user gives “Got AS-REP (no  
pre-auth) but couldn’t decrypt — bad password” output. This shows that  
the l.clark user accepts plaintext password entries, so we can perform a  
brute force attack.

![](https://miro.medium.com/v2/resize:fit:700/1*-mgvdjONeimYBk8s210KeQ.png)

![](https://miro.medium.com/v2/resize:fit:700/1*lIqtVn-KMZTJIVbnaWFtig.png)

![](https://miro.medium.com/v2/resize:fit:700/1*27WJ41HIqINCEt9Y2xJP1w.png)

![](https://miro.medium.com/v2/resize:fit:700/1*-_tM1dw-s43Wdq05HIlIvw.png)

![](https://miro.medium.com/v2/resize:fit:409/1*E1349suRTOcWFVA47Vxikw.png)

## Active Directory Structure

![](https://miro.medium.com/v2/resize:fit:700/1*xujum-LQRV4l9qb16JV-2w.png)

## Initial Access

![](https://miro.medium.com/v2/resize:fit:700/1*Kgg6Kcy_XTFG2-n45gEjbg.png)

![](https://miro.medium.com/v2/resize:fit:700/1*pNYqvwVZBJ-NUwA5gLZ-Cg.png)

## Meterpreter Escelation

![](https://miro.medium.com/v2/resize:fit:700/1*M05JpzaLU7FlPv61T5Ga9g.png)

![](https://miro.medium.com/v2/resize:fit:700/1*F6D9597wjdxKIfUBxa6dpg.png)

# Privilege Esceletion

In netstat command we can barely see there is a server running name Output Messenger.

![](https://miro.medium.com/v2/resize:fit:700/1*VYbbUAGUmTtVNkRuhPMY_Q.png)

![](https://miro.medium.com/v2/resize:fit:700/1*zeRFxpTe2U7BA6Xjgr3e4A.png)

If you take a look at the contents of the C:\AppData folder, there are  
many files containing information about the Output Messenger server. If  
you examine the files stored as .zip, you can get a lot of information  
about the MySQL server to which the server is connected.

Using Chisel we can access the Output Messenger server running on these  
ports from our local computer. To do this, we first need to download  
Chisel both to the target machine and to our own machine. You can easily  
do this with meterpreter’s upload command.

![](https://miro.medium.com/v2/resize:fit:700/1*LlqsFeLnbhh_fsVuMB3qEw.png)

![](https://miro.medium.com/v2/resize:fit:700/1*WHweKMEqXOJGSLken-M9EQ.png)

![](https://miro.medium.com/v2/resize:fit:700/1*wYxQZ4Em0S7RFkN_hgsGHg.png)

## MITRE ATT&CK Techics used:

-   T1585
-   T1078
-   T1059.003
-   T1068
-   T1550.003
-   T1558.003
-   T1087.002
-   T1615
-   T1046
-   T1069.002
