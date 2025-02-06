---
title: Brute It
tags:
  - thm
  - easy
---
# TryHackMe: Brute-It Write-Up
> **Herkese merhabalar bu yazımda TryHackMe: Brute-It CTF'inin nasıl çözüldüğünü anlatacağım.**

- Nap ve Ffuf çalıştırdım. Ffuf daha hızlı olduğundan gobuster yerine Ffuf kullanıyorum. Nmap sonuçlarına göre ssh’ın açık olduğunu gördüm. Ayrıca /admin sayfasını buldum.

![](/static/bruteit/Nmap.png)
![](/static/bruteit/Ffuf.png)
--
- Böyle bir login sayfasıyla karşılaştım:

![](/static/bruteit/Login-Page.png)
--
- Kaynak koduna baktığımda John adlı bir kullanıcı olduğunu fark ettim. Ve kullanıcı adının admin olduğunu öğrendim.

![](/static/bruteit/Source-Code.png)
--
- Elimizde kullanıcı adı ve bir login sayfası var. Aklıma hemen hydra ile brute force yapmak geldi.

![](/static/bruteit/Hydra.png)
--
- Kullanıcı adı ve şifreyi girdikten sonra bu sayfayla karşılaştım:

![](/static/bruteit/RSA-Private-Key.png)
--
- John aracı ile verilen RSA private keyi crackledim.

![](/static/bruteit/Crack-RSA.png)
--
- Ssh ile john kullanıcısına bağlanmayı denedim. İlk denememde “UNPROTECTED PRIVATE KEY FILE” uyarısı aldım. Chmod ile private key dosyasına yetki verdim ve yeniden ssh ile bağlanmayı denedim. John ile bulduğum şifreyi girdim ve bağlandım.

![](/static/bruteit/SSH.png)
--
Sudo -l komutu ile root olarak çalıştırabileceklerimize bakılır ve cat komutunun çalıştığı fark edilir. “sudo cat /etc/shadow” komutu kullanılır.

![](/static/bruteit/Sudo-l.png)
--
Root adlı kullanıcının hashini bir dosyaya atıyoruz ve john kullanarak bunu crackliyoruz.

![](/static/bruteit/Crack-Hash.png)
--
Şifreye ulaştık root kullanıcısı olarak giriş yapıyoruz.

![](/static/bruteit/Root.png)









