# [SKYSEC Articles | Quartz](https://skysec.yildizskylab.com/)


# Nasıl İçerik Hazırlarım?
## Repositoryi Klonla
```bash
git clone https://github.com/skylab-kulubu/skysec-article-quartz.git
```
```bash
cd skysec-article-quartz
```
## Markdown Formatı
İçeriğini [Markdown](https://www.markdownguide.org/) işaretleme dili ile hazırlamış olman gerekli!
## Metin Konumu
Metinlerini `.md` formatındaki dosyalarda barındırmalısın. `content/` klasöründe bulunan klasörlerden senin içeriğine uygun olan kategoriyi belirleyerek o klasörün içerisinde konumlandırmalısın. Örneğin, bir zafiyetli makinenin çözümünü paylaşacaksan `content/CTF Write-Ups/oda_adi.md` konumuda bulunmalı.
## Görseller
Eğer görselleri bu repository içerisinde barındırmak istiyorsan `quartz/static/içeriğinin_adi/` isimli klasörde barındırman gerekli! Aşağıdaki kullanım örneğine bakarak görselleri içeriğinde kullanabilirsin.

```markdown
![](/static/klasör_adi/resim_adi.png)
```

## Properties
Her makalenin kendine has özellikleri var, bunu yazını paylaşmadan önce belirtirsen ulaşılması sonradan daha basit olur. Örneğin, [HachTheBox](https://app.hackthebox.com/) platformundan orta zorlukta [Heal](https://app.hackthebox.com/machines/Heal) isimli odayı çözdün ve çözümünü paylaşmak istiyorsun.

```markdown
---
title: Heal
tags:
  - htb
  - medium
---
```
bu metni yazının en üst kısmında konumlandırırsan [Heal](https://app.hackthebox.com/machines/Heal) makinesini, orta zorluktaki makineleri veya [HachTheBox](https://app.hackthebox.com/) platformuna ait makineleri arayan birisi daha kolay bulabilir.

---
Bütün bu özellikleri [Markdown](https://www.markdownguide.org/) formatında kod olarak görmek istiyorsan [bu yazıya](https://github.com/skylab-kulubu/skysec-article-quartz/blob/v4/content/CTF%20Write-Ups/heal.md) göz atabilirsin.

# Obsidian
[Obsidian](https://obsidian.md/) bir not tutma uygulaması, aynı zamanda [Quartz](https://quartz.jzhao.xyz/) ile uyumlu çalışmakta. Repositorynin klasörünü [Obsidian](https://obsidian.md/) ile açarsan, vault olarak, yazdığın Markdown formatındaki yazılar websitesinde nasıl görünecekse sana da öyle gözükecek.