---
title: PermX
tags:
  - htb
  - easy
  - retired
---

<div align='center'>
  
# [PermX](https://app.hackthebox.com/machines/PermX)

</div>

# Discovery

![1](https://github.com/user-attachments/assets/e5b390b3-d02c-44d7-8dfc-6e0ef9b9b894)

![2](https://github.com/user-attachments/assets/4ecf9dd4-b2f3-4fb6-a72a-46eb6b75bdc1)

From the `Nmap` scan, we see that only ports `22` and `80` are open.

![3](https://github.com/user-attachments/assets/93ca42fd-d9cf-4316-8a24-b6bd4b4182ab)

When we scan `Virtual Host` with `FFuZ` tool, we see that there are two subdomains, `www.permx.htb` and `lms.permx.htb`.

![4](https://github.com/user-attachments/assets/45c88da8-14cd-47c6-9deb-4a998555da67)

To access the `lms.permx.htb` subdomain, edit the `/etc/hosts` file.

![5](https://github.com/user-attachments/assets/ab017e56-6e71-4577-8e2e-6a9094b1b788)

When we go to `lms.permx.htb`, we see that the `Chamilo Learning Management System` application is running, it asks for username and password input to log in.

![6](https://github.com/user-attachments/assets/59325b54-16ae-4c0a-b0cc-2e4179e6e898)

# Initial Access

With a simple Google, it seems that there is a `CVE` record with an `Unauthenticated RCE` vulnerability.

![7](https://github.com/user-attachments/assets/7e977a7f-ebeb-411b-96dd-f4d489ad491e)

![8](https://github.com/user-attachments/assets/6b6ca43e-09ce-4188-be6f-e4f5cf5223f1)

![9](https://github.com/user-attachments/assets/eb89dc83-cb6c-419f-9f75-ff618880666e)

![9_10](https://github.com/user-attachments/assets/750eed59-9982-49e7-8de8-608bf00e310b)

# User

When I examine the files in the `/var/www/camilo` directory, I see that the `cli-config.php` file contains information for database access.

![9_11](https://github.com/user-attachments/assets/1adb36c5-dc51-4d3a-9cea-050edaad413e)

I use the `grep` command to search for the file containing this database information and find the file containing all the data required for the database connection. When I use the password for the database to log in to the user `mtz` I am successful

![9_12](https://github.com/user-attachments/assets/defa4cbe-453b-46a3-903a-70aa829155c0)

# Root

When I run the `sudo -l` command, I see that I am authorised to run the file `/opt/acl.sh` as `root`. When I examine this file, I understand that I can change the write, read and execute permissions of a file as long as it is in the `/home/mtz` directory.

![9_13](https://github.com/user-attachments/assets/ea8869ea-4647-419b-b9e8-f85f941b3d77)

I link `/etc/shadow` to `/home/mtz/shadow` with the command `ln -s /etc/shadow /home/mtz/shadow` and give myself write, read and run permission with the command `sudo /opt/acl.sh mtz rwx /home/mtz/shadow`. Then I edit the `shadow` file with the command `vim /home/mtz/shadow` and delete the password of the `root` user.

![9_14](https://github.com/user-attachments/assets/78d1866c-33f3-41ac-bfb2-11d0e9c0d91f)

![9_15](https://github.com/user-attachments/assets/e52142c4-bcbb-4b10-ad74-7fb6fb1c5bfb)

![9_16](https://github.com/user-attachments/assets/fb604cb1-e321-4edf-9d8a-05ce76768a40)









