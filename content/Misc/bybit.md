---
title: ByBit Hacking Report
tags:
  - forenscis
date: 2025-02-27
---
Lazarus Group, Safe{Wallet}'ın AWS S3 bucket'ına sızarak kötü amaçlı bir JavaScript kodu enjekte etti. Bu kod, özellikle Bybit ve başka bir test sözleşmesine ait işlemleri hedef aldı ve işlem imzalama sürecinde bu işlemleri manipüle ederek 1,4 milyar dolarlık kayba neden oldu. Saldırıdan sadece 2 dakika sonra, kötü amaçlı kodun temizlenmiş yeni bir versiyonu sisteme yüklendi. Şu ana kadar yapılan incelemeler, saldırının Safe{Wallet}'ın AWS altyapısından kaynaklandığını gösteriyor. Bybit'in kendi sistemlerinde herhangi bir güvenlik ihlali tespit edilmemiş.

	![[/static/misc/bybit/1.jpg]]![[/static/misc/bybit/2.jpg]]![[/static/misc/bybit/3.jpg]]