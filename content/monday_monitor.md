---
title: Monday Monitor
tags:
  - thm
  - soc
---
# [TryHackMe Monday Monitor](https://tryhackme.com/r/room/mondaymonitor)
First of all, we must log in to the Wazuh interface and enter the `Policy Monitoring` tab.

![image](https://i.hizliresim.com/otf6elk.jpg)
![image](https://i.hizliresim.com/8y442vi.jpg)
Then enter the `Events` section

![image](https://i.hizliresim.com/81uebw0.jpg)
We can analyse more easily by setting the required data sections, turn on the columns `data.win.eventdata.commandLine`, `data.win.eventdata.image`, `data.win.eventdata.parentImage` and turn off the other standard columns.
You can start examining after you set the date order from the most recent to the oldest.
## Tasks
### Data was exfiltrated from the host. What was the flag that was part of the data?
![](https://i.hizliresim.com/cq8keox.jpg)
### What password was set for the new user account?
![](https://i.hizliresim.com/56beg6a.jpg)
### What is the name of the .exe that was used to dump credentials?
`Mimikatz` was executed via an `.exe` file! `Mimikatz` obtains the encrypted user passwords of the users on the system from the encrypted version in memory, breaks the password and returns it in plain text. In this command, after specifying the file path where `Mimikatz` is found as an environment variable, it runs the suspicious `.exe` file.
![](https://i.hizliresim.com/mqtr1od.jpg)
### What time is the scheduled task meant to run? What is the full command run to create a scheduled task? What was encoded?

The `reg add` command saves the `HKCU\\\SOFTWARE\\\ATOMIC-T1053.005` Registry record, which stores the string value `cGluZyB3d3cueW91YXJldnVsbmVyYWJsZS50aG0=`. When we decode this string value via [`Cyberchef`](https://cyberchef.org), you can learn that it is a `Base64` string and you can learn the equivalent of this value. 

Immediately after this command, the `"IEX([System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String((Get-ItemProperty -Path HKCU:\\\\SOFTWARE\\ATOMIC-T1053.005. 005).test))))\"` and execute this command at `HH:MM` of the day with the parameter `/sc daily /st HH:MM\`. 

> HH:MM is a censored time, you will see something like `13:06` in the logs.
![](https://i.hizliresim.com/5gd5ozr.jpg)
![](https://i.hizliresim.com/dfihl9s.jpg)
### Initial access was established using a downloaded file. What is the file name saved on the host?
An `HTTP` request is made through an `Office` file and `PhishingAttachment.xlsm` is saved as output.
![](https://i.hizliresim.com/p01wlna.jpg)