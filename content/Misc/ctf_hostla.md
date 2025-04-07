---
title: Kendi CTF'ini Hostla!
tags:
  - guide
date: 2025-04-01
---
# Kendi CTF’ini Hostla

# Gereksinimler

Burada değineceğim gereksinimler elbette olmazsa olmaz değil ve başka yöntemlerle halledilebilir fakat CTF yarışmalarının kısa süreli olduğunu düşünürsek bu yöntemleri kullanmamız bizim yararımıza olacaktır.

- Bir bulut sağlayıcısından hesap
- 3 adet VPS (sunucu)
- 1 adet bulut ağı (cloud network)

Bu yazıda bulut sağlayıcısı olarak **Hetzner**’i kullanacağım fakat siz `AWS`, `Digital Ocean` gibi muadilleri elbette kullanabilirsiniz. hcloud-cli aracı ile kurulumu gerçekleştirmek

```bash
#!/bin/bash  
SSH_KEY="KEY_NAME_HERE"  
hcloud network create --name skydays-internal --ip-range 172.16.0.0/24  
hcloud network add-subnet --type cloud --network-zone eu-central skydays-internal  
hcloud server create \  
  --image ubuntu-24.04 \  
  --type cpx41 \  
  --ssh-key $SSH_KEY \  
  --without-ipv6 \  
  --network skydays-internal \  
  --name skydays-bind  
  
hcloud server create \  
  --image ubuntu-24.04 \  
  --type cpx41 \  
  --ssh-key $SSH_KEY \  
  --without-ipv6 \  
  --network skydays-internal \  
  --name skydays-vpn  
  
hcloud server create \  
  --image ubuntu-24.04 \  
  --type cpx41 \  
  --ssh-key $SSH_KEY \  
  --without-ipv6 \  
  --network skydays-internal \  
  --name skydays-questions
```

# Sunucular

3 adet sunucumuz olacak, bunlar sırasıyla `DNS`, `CTFd`, `VPN` ve Soru servislerini çalıştıracak. Her bir sunucuya `SSH` ile bağlandıktan sonra aşağıdaki komutu çalıştırın:

```bash
apt update -y;apt upgrade -y;curl https://get.docker.com|bash;alias dc='docker compose '
```

Bu komut sunucuyu güncelleyecek ve Docker’ı kuracak. `tmux` komutunu girerek SSH bağlantınızı çoğaltabilirsiniz fakat bilginiz yoksa gerek yok.

## VPN

VPN sunucunuza girdikten sonra aşağıdaki komutu girerek Wireguard yazılımını sunucunuza kurun

```bash
apt install wireguard -y
```

ardından aşağıdaki komutları sırasıyla çalıştırın:

```bash
mkdir ~/wg-ui  
cd ~/wg-ui  
curl -o compose.yml https://github.com/skylab-kulubu/SKYDAYS-CTF-25/raw/refs/heads/main/ctf-utils/wireguard-vpn/compose.yml
```

```yaml
version: "3"  
  
services:  
  wireguard-ui:  
    image: ngoduykhanh/wireguard-ui:latest  
    container_name: wireguard-ui  
    cap_add:  
      - NET_ADMIN  
    # required to show active clients. with this set, you don't need to expose the ui port (5000) anymore  
    network_mode: host  
    environment:  
      - SENDGRID_API_KEY  
      - EMAIL_FROM_ADDRESS  
      - EMAIL_FROM_NAME  
      - SESSION_SECRET  
      - WGUI_USERNAME=admin  
      - WGUI_PASSWORD=admin  
      - WG_CONF_TEMPLATE  
      - WGUI_MANAGE_START=true  
      - WGUI_MANAGE_RESTART=true  
      # Custom Settings  
      - WGUI_DEFAULT_CLIENT_ALLOWED_IPS=10.0.0.0/16  
      - WGUI_SERVER_INTERFACE_ADDRESSES=10.10.0.0/16,10.0.0.0/16  
      - WGUI_SERVER_POST_UP_SCRIPT=iptables -t nat -A POSTROUTING -s 10.0.0.0/8 -o eth0 -j MASQUERADE; iptables -A INPUT -p udp -m udp --dport 51820 -j ACCEPT; iptables -A FORWARD -i wg0 -j ACCEPT; iptables -A FORWARD -o wg0 -j ACCEPT;  
      - WGUI_DEFAULT_CLIENT_USE_SERVER_DNS=false  
      # EMAIL options  
      - EMAIL_FROM_ADDRESS=${EMAIL_ADDRESS}  
      - EMAIL_FROM_NAME=Wireguard VPN  
      - SMTP_HOSTNAME=smtp.gmail.com  
      - SMTP_PORT=587  
      - SMTP_USERNAME=${EMAIL_ADDRESS}  
      - SMTP_PASSWORD=${APPLICATION_PASSWORD}  
      - SMTP_AUTH_TYPE=LOGIN  
    logging:  
      driver: json-file  
      options:  
        max-size: 50m  
    volumes:  
      - db:/app/db  
      - /etc/wireguard:/etc/wireguard  
  
volumes:  
  db:
```

komutları çalıştırdıktan sonra `compose.yml` dosyası yukarıdaki gibi olacaktır. Burada bizi ilgilendiren birkaç değişken var.

Eğer ağ yapılandırmasını değiştirmek istiyorsanız

- `WGUI_DEFAULT_CLIENT_ALLOWED_IPS`
- `WGUI_SERVER_INTERFACE_ADDRESSES`
- `WGUI_SERVER_POST_UP_SCRIPT`
- `WGUI_DEFAULT_CLIENT_USE_SERVER_DNS`

değişkenlerini değiştirmelisiniz. Mevcut durumunda `10.0.0.0/16` subnetinde sunucular `10.10.0.0/16` subnetinde yarışmacıları (client) bulundurmakta. Post-Up scriptinde ise gereki firewall izinlerini vermekte.

Yarışmacılara VPN dosyalarını e-posta ile göndermek için YAML dosyasındaki gerekli değişkenleri atayın veya aşağıdaki komutları çalıştırın.

```bash
export EMAIL_ADDRESS=your@gmail.com  
export APPLICATION_PASSWORD="app password here"
```

Her şey tamamsa `dc up -d` (eğer alias işlemini yapmadıysanız `docker compose up -d` ) komutunu çalıştırarak sunucunuzun Public IPv4 adresinin `5000` portu üzerinden `admin:admin` giriş bilgilerini kullanarak yönetim paneline giriş yapabilirsiniz.

- `10.0.0.0/16` → sunucular
- `10.10.0.0/16` → yarışmacılar (clientlar)

E-posta adresinize gönderilen `wg0.conf` dosyasını `/etc/wireguard` klasörüne koyun, ardından `sudo wg-quick up wg0` komutu ile ağa bağlanın. Herhangi bir sorun yaşamanız durumunda `sudo wg-quick down wg0` komutu ile VPN bağlantısını sonlandırıp `sudo wg-quick up wg0` komutu ile tekrar başlatınız.

VPN bağlantısını test ettikten sonra başarılı olduysanız aşağıdaki komutu çalıştırarak güvenlik duvarını akif edin

```bash
curl -L https://github.com/skylab-kulubu/SKYDAYS-CTF-25/raw/refs/heads/main/ctf-utils/wireguard-vpn/firewall.sh|bash
```

script içeriği:

```bash
#!/bin/bash  
  
sed -i.bak "s/IPV6=yes/IPV6=no/g" /etc/default/ufw  
  
ufw reset  
  
ufw default deny incoming  
ufw default allow outgoing  
  
ufw allow ssh  
ufw allow from 10.0.0.0/16 to 10.0.0.0/16  
ufw allow from 10.0.0.0/16 to 10.10.0.0/16  
ufw allow from 10.10.0.0/16 to 10.0.0.0/16  
ufw deny from 10.10.0.0/16 to 10.10.0.0/16  
ufw allow 5000  
ufw allow 51820/udp  
  
ufw reload  
  
ufw enable  
# Wireguard Logs  
iptables -I FORWARD -i wg0 -j LOG --log-prefix 'tunnel wireguard iptables: ' --log-level 7  
iptables -I FORWARD -o wg0 -j LOG --log-prefix 'tunnel wireguard iptables: ' --log-level 7
```
  
## DNS

Gerekli yazılımları kurmak için

```bash
sudo apt install bind9 bind9utils bind9-doc dnsutils -y
```

```bash
cat /etc/bind/named.conf  
---SNIP---  
include "/etc/bind/named.conf.local";  
include "/etc/bind/named.conf.options";  
---SNIP---
```

`/etc/bind/named.conf.local` dosyasının içerisine istediğin alan adlarını gireceksiniz, örneği `benimctfim.ctf` sizin CTFd sunucunuzu görsterecek olsun.

```
zone "benimctfim.ctf" {  
    type master;  
    file "/etc/bind/db.benimctfim.ctf";  
};
```

```
cat /etc/bind/db.benimctfim.ctf  
$TTL 86400  
@   IN  SOA ns.benimctfim.ctf. admin.benimctfim.ctf. (  
        2024030801  ; Serial  
        3600        ; Refresh  
        1800        ; Retry  
        604800      ; Expire  
        86400 )     ; Minimum TTL  
  
    IN  NS  ns.benimctfim.ctf.  
ns  IN  A   10.0.0.1  
@   IN  A   10.0.0.1
```

Bu örnekte CTFd sunucusunun VPN ağındaki IPv4 adresi `10.0.0.1` olarak belirtlilmiş, adresi kendi durumunuza göre düzenlemelisiniz. İlk kaydınızı tamamladıktan sonra aşağıdaki komutu çalıştırarak DNS servisinizi başlatabilirsiniz.

```bash
sudo systemctl restart bind9  
sudo systemctl enable bind9
```

Aşağıdaki komutla DNS servisinizin çalışma durumunu test edebilirsiniz, bu örnekte DNS servisinin VPN ağındaki IPv4 adresi 10.0.0.1, siz kendi durumuza göre değiştirmelisiniz.

```
nslookup benimctfim.ctf 10.0.0.1
```

Eğer IPv4 adresi `10.0.0.1` olarak döndüyse tebrikler!

Son olarak gelen isteklerin internet üzerinden de sorgu yapmasını sağlayalım

```
sudo cat /etc/bind/named.conf.options  
options {  
    directory "/var/cache/bind";  
  
    forwarders {  
        8.8.8.8;  
        8.8.4.4;  
    };  
  
    allow-query { any; };  
    recursion yes;  
    listen-on { any; };  
    listen-on-v6 { any; };  
};
```

Şimdi ise bir soru için alan adı ekleyelim.

```
zone "benimilksorum.ctf" {  
    type master;  
    file "/etc/bind/db.benimilksorum.ctf";  
};
```

```
cat /etc/bind/db.benimilksorum.ctf  
$TTL 86400  
@   IN  SOA ns.benimilksorum.ctf. admin.benimilksorum.ctf. (  
        2024030801  ; Serial  
        3600        ; Refresh  
        1800        ; Retry  
        604800      ; Expire  
        86400 )     ; Minimum TTL  
  
    IN  NS  ns.benimilksorum.ctf.  
ns  IN  A   10.0.0.0 ;BURADA VPN SUNUCUNUZUN ADRESİ OLMALI  
@   IN  A   10.0.0.2 ;BURADA SORUNUZUN OLDUĞU SUNUCUNUN VPN IPV4 ADRESİ OLMALI
```

son olarak aşağıdaki komutu çalıştırarak kaydı güncel sisteme ekleyelim

```bash
sudo systemctl restart bind9
```

## CTFd

CTFd bütün CTF’in yönetildiği, yarışmacıların göreceği kısım.

```bash
# Clone CTFd   
git clone https://github.com/CTFd/CTFd.git ~/.ctfd  
cd ~/.ctfd  
  
  
# Start CTFd On Port 80  
docker compose up -d --force-recreate --build
```

yukarıdaki komutları kullanarak kurulumu yapabilirsiniz, DNS sunucunuzun içerisinde yapmanız sizin için kolaylık sağlayacaktır.

Geri kalan işlemleri CTFd panelinden gerçekleştirebilirsiniz.

## Sorular

Soruların olduğu sunucuda aşağıdaki komutu çalıştırarak Web sorularının alan adlarına özel yönlendirmeleri yapabilirsiniz.

```bash
mkdir ~/proxy  
cd ~/proxy  
curl -o compose.yml https://github.com/skylab-kulubu/SKYDAYS-CTF-25/raw/refs/heads/main/ctf-utils/reverse-proxy/compose.yml  
docker compose up -d
```

Soruların bulunduğu sunucunun VPN üzerindeki IPv4 adresini kullanarak 81 portundan panele giriş yapabilirsiniz, gerekli yönlendirmeleri buradan gerçekleştireceksiniz.

## Firewall

Bütün sunucularda aşağıdaki komutları çalıştırarak istekleri VPN içerisinden kabul edebilirsiniz. **VPN sunucusu hariç**

```bash
sed -i.bak "s/IPV6=yes/IPV6=no/g" /etc/default/ufw  
  
ufw reset  
  
ufw default deny incoming  
ufw default allow outgoing  
ufw allow ssh  
ufw allow from 10.0.0.0/16  
ufw allow from 10.10.0.0/16
```

## Network Şeması

![network digram](/static/misc/ctf_hostla/ctf_hostla.png)
