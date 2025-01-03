---
title: Sea
draft: false
tags:
  - htb
  - easy
---

# Sea
- T1566.002
- T1204.001
- T1068
- T1127
  
# Discovery

![Screenshot_20240813_104437](https://github.com/user-attachments/assets/0d5fb50b-eb6f-4290-94cb-439fc5f5156e)

When we look at the source code of the HTML page, we see that static files for the website are kept in the path `themes/bike/velik71***`. Unfortunately, we cannot access the `/themes` path because we are not authorized, but we can easily access it if we know the names of the files.

![Screenshot_20240813_105124](https://github.com/user-attachments/assets/bee445e2-4dd7-4d5b-9654-7b516c788977)

When we search `themes/bike/velik71` on Google, we see that a Content Management System called `WonderCMS` uses these theme files, you can also find the Github repository when you search in detail.

![Screenshot_20240813_105224](https://github.com/user-attachments/assets/8d03f37f-4018-4c67-881d-ba70b03708fa)

![Screenshot_20240813_105401](https://github.com/user-attachments/assets/f0d94ca4-8f0e-48eb-9e94-6185d0df1c93)

![Screenshot_20240813_105720](https://github.com/user-attachments/assets/e4af5bc7-de85-4667-a5f5-08815db44ee5)

![Screenshot_20240813_110021](https://github.com/user-attachments/assets/66971b1b-bfbf-41fb-a79f-ceb2471842a0)

As you can see from the photos above, in a CVE vulnerability created for `WonderCMS`, the administrator of our website is phishing attacked and creates a vulnerability in the website.
# Web Exploit

![Screenshot_20240813_110241](https://github.com/user-attachments/assets/207c0158-8cba-4936-bbef-4afe0b43f9dd)

![Screenshot_20240813_110421](https://github.com/user-attachments/assets/743c4dc8-af7e-4243-a931-0c5b123f8dba)

![Screenshot_20240813_110540](https://github.com/user-attachments/assets/5fc658b0-25b5-4b19-ac91-e13fbf6a3ae6)

In the `/var/www/sea` folder we see some files related to our website, if we take a look at the `data` folder you can see the configuration files related to the database. The user password required to access the database is encrypted in `Becrypt` format.

![Screenshot_20240813_110751](https://github.com/user-attachments/assets/30cb62ac-10b2-4ad6-9ba3-fa8423cbe951)



![Screenshot_20240813_110903](https://github.com/user-attachments/assets/702ff84c-d859-48bb-a16b-a8ef5ab0e050)


![Screenshot_20240813_111027](https://github.com/user-attachments/assets/66bb1eba-9bea-4147-9e6d-30b1a80baa58)


![Screenshot_20240813_111108](https://github.com/user-attachments/assets/478bb641-fe95-4c5a-a6f2-a6a0e6fc255a)


![Screenshot_20240813_111204](https://github.com/user-attachments/assets/9be41c85-2f1e-419c-abea-22e0b4a5e34f)

# Privilege Esc.
![Screenshot_20240813_111255](https://github.com/user-attachments/assets/8d72fde5-4381-403a-949e-7d4a5de3b93e)

![Screenshot_20240813_111417](https://github.com/user-attachments/assets/165d4564-f612-46f0-a50f-2897283993c4)

![Screenshot_20240813_111538](https://github.com/user-attachments/assets/4fe1b9a2-e790-4180-8d75-21c14c5ae959)

![Screenshot_20240813_111608](https://github.com/user-attachments/assets/d5b7a060-187e-410e-b35b-c7a55a173b6c)

![Screenshot_20240813_112512](https://github.com/user-attachments/assets/fb1cd7e6-265a-4f42-9f82-f4d0f0bfb386)
