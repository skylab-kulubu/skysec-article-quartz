---
title: Elasticsearch Loadbalancer And Kibana Installation
tags:
  - siem
  - blue
  - elk
date: 2025-07-18
---

# Elasticsearch and Kibana SSL Configuration and Load Balancer Setup

This document describes the detailed steps for configuring SSL certificates, setting up a secure Elasticsearch cluster, and configuring Kibana with an Nginx reverse proxy and load balancer.

## 1. Generating SSL Certificates

### Retrieve `.p12` Keystore Password

Execute the following command on your Elasticsearch node to obtain the keystore password:

```bash
/usr/share/elasticsearch/bin/elasticsearch-keystore show xpack.security.http.ssl.keystore.secure_password
```

### Extract Private Key from `.p12` Keystore

Run this command to extract the `.key` file from your existing `http.p12` file:

```bash
openssl pkcs12 \
  -in /etc/elasticsearch/certs/http.p12 \
  -nodes -nocerts | \
openssl rsa -out /etc/elasticsearch/certs/http_ca.key
```

## 2. Setting Up the Load Balancer Certificate

Generate a certificate for the Kibana server:

```bash
/usr/share/elasticsearch/bin/elasticsearch-certutil cert \
  --ca-cert /etc/elasticsearch/certs/http_ca.crt \
  --ca-key /etc/elasticsearch/certs/http_ca.key \
  --ip 37.27.x.x \
  --name kibana \
  --out /root/kibana.zip \
  --pem
```

Transfer the generated `kibana.zip` and the `http_ca.crt` file to your Kibana server.

## 3. Installing Kibana

### Download and Install Kibana

Download the Kibana Debian package from the official site and install it:

```bash
wget https://artifacts.elastic.co/downloads/kibana/kibana-9.0.3-amd64.deb
dpkg -i kibana-9.0.3-amd64.deb
```

### Configure Kibana (`/etc/kibana/kibana.yml`)

```yaml
server.port: 5601
server.host: localhost
server.publicBaseUrl: "https://37.27.x.x"
server.ssl.enabled: true
server.ssl.certificate: /etc/kibana/certs/kibana.crt
server.ssl.key: /etc/kibana/certs/kibana.key
elasticsearch.hosts: ["https://localhost:9200"]
elasticsearch.ssl.certificateAuthorities: ["/etc/kibana/certs/http_ca.crt"]
elasticsearch.ssl.verificationMode: "certificate"
```

## 4. Configuring Nginx Reverse Proxy and Load Balancer

### Install Nginx

```bash
apt install nginx -y
```

### Create Nginx Configuration File (`/etc/nginx/sites-available/loadbalancer`)

```nginx
upstream backend_servers {
    server 192.168.122.2:9200;
    server 192.168.122.3:9200;
    server 192.168.122.4:9200;
}

server {
    listen 9200 ssl http2;
    server_name 37.27.x.x;

    ssl_certificate /etc/kibana/certs/kibana.crt;
    ssl_certificate_key /etc/kibana/certs/kibana.key;

    location / {
        proxy_pass https://backend_servers;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

### Test the Load Balancer

Use the following command to verify your load balancer:

```bash
curl -k -u elastic:elastic 'https://37.27.x.x:9200/_cat/nodes?pretty'
```

## 5. Configure Kibana Reverse Proxy

Update the Nginx configuration:

```nginx
server {
    listen 80;
    server_name 37.27.x.x;

    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl;
    server_name 37.27.x.x;

    ssl_certificate /etc/kibana/certs/kibana.crt;
    ssl_certificate_key /etc/kibana/certs/kibana.key;

    location / {
        proxy_pass https://localhost:5601;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

## 6. Creating and Configuring Kibana Service Token

### Generate Service Token

Run this command to generate a service token for Kibana:

```bash
curl -XPOST -k -u elastic:elastic 'https://37.27.x.x:9200/_security/service/elastic/kibana/credential/token/kibana_token'
```

### Add Service Token to Kibana Keystore

Add the generated token into the Kibana keystore:

```bash
/usr/share/kibana/bin/kibana-keystore add elasticsearch.serviceAccountToken
```

## 7. Firewall Configuration

Configure firewall rules using Hetzner Cloud CLI to secure your Kibana server:

```bash
hcloud firewall create --name kibana
hcloud firewall add-rule --direction in --protocol tcp --port 22 kibana
hcloud firewall add-rule --direction in --protocol tcp --port 443 kibana
hcloud firewall add-rule --direction in --protocol tcp --port 80 kibana
```

By following these steps, your Elasticsearch and Kibana setup will be secure, reliable, and properly load balanced.