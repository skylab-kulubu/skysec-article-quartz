---
title: Multinode Elasticsearch Cluster With SSL
tags:
  - blue
  - siem
  - elk
date: 2025-07-18
---

# Setting Up a Secure Elasticsearch Cluster (On Hetzner Cloud)

In this guide, we will set up a secure Elasticsearch cluster with three Elasticsearch nodes and one Kibana node, using SSL encryption. The installation can be performed either on virtual machines or via cloud providers. Here, we will use Hetzner Cloud.

## Initial Setup

### Create Cloud Servers

We will create four virtual machines:

- **Three Elasticsearch nodes** (`es-node1`, `es-node2`, `es-node3`)
    
- **One Kibana node** (`kibana`)
    

Use the following commands:

```bash
hcloud server create --image ubuntu-24.04 --name es-node1 --without-ipv6 --ssh-key $SSH_KEY --type cpx11
hcloud server create --image ubuntu-24.04 --name es-node2 --without-ipv6 --ssh-key $SSH_KEY --type cpx11
hcloud server create --image ubuntu-24.04 --name es-node3 --without-ipv6 --ssh-key $SSH_KEY --type cpx11
hcloud server create --image ubuntu-24.04 --name kibana --without-ipv6 --ssh-key $SSH_KEY --type cpx11
```

### Create and Attach Servers to a Private Network

```bash
hcloud network create --name elk --ip-range 192.168.122.0/24
hcloud network add-subnet --ip-range 192.168.122.0/24 --network-zone eu-central --type cloud elk

hcloud server attach-to-network --network elk es-node1
hcloud server attach-to-network --network elk es-node2
hcloud server attach-to-network --network elk es-node3
hcloud server attach-to-network --network elk kibana
```

### Verify Server Status

Check your servers:

```bash
hcloud server list
```

Expected output:

```plaintext
ID          NAME       STATUS    IPV4           IPV6   PRIVATE NET           DATACENTER   AGE
104548247   es-node1   running   46.62.x.x      -      192.168.122.2 (elk)   hel1-dc2     7m
104548473   es-node2   running   46.62.x.x      -      192.168.122.3 (elk)   hel1-dc2     5m
104548619   es-node3   running   46.62.x.x      -      192.168.122.4 (elk)   hel1-dc2     4m
104549178   kibana     running   37.27.x.x      -      192.168.122.5 (elk)   hel1-dc2     26s
```

## Installing Elasticsearch

### Setup `/etc/hosts`

To simplify access, edit your `/etc/hosts` file:

```bash
# /etc/hosts
46.62.x.x es-node1
46.62.x.x es-node2
46.62.x.x es-node3
37.27.x.x kibana
```

### Ansible Inventory

Create an Ansible inventory for easier management:

```toml
[es-nodes]
46.62.x.x
46.62.x.x
46.62.x.x

[kibana]
37.27.x.x
```

### Elasticsearch Installation via Ansible

Use the following playbook:

```yaml
- hosts: es-nodes
  remote_user: root
  tasks:
    - name: Download Elasticsearch package
      get_url:
        url: https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-9.0.3-amd64.deb
        dest: /tmp/elasticsearch-9.0.3-amd64.deb

    - name: Install Elasticsearch package
      apt:
        deb: /tmp/elasticsearch-9.0.3-amd64.deb
```

## Elasticsearch Node Configuration

### Node 1 Configuration

Start Elasticsearch on Node 1:

```bash
systemctl start elasticsearch
```

Edit `/etc/elasticsearch/elasticsearch.yml`:

```yaml
cluster.name: es-cluster
node.name: es-node1
network.host: 192.168.122.2
```

### Node 2 & 3 Configuration

On Node 1, generate an enrollment token:

```bash
/usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s node
```

Configure Node 2:

```bash
/usr/share/elasticsearch/bin/elasticsearch-reconfigure-node --enrollment-token <token>
```

Edit Node 2 configuration:

```yaml
cluster.name: es-cluster
node.name: es-node2
network.host: 192.168.122.3
```

Start Elasticsearch on Node 2:

```bash
systemctl start elasticsearch
```

Repeat for Node 3:

```bash
/usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s node
/usr/share/elasticsearch/bin/elasticsearch-reconfigure-node --enrollment-token <token>
```

Edit Node 3 configuration:

```yaml
cluster.name: es-cluster
node.name: es-node3
network.host: 192.168.122.4
```

Start Elasticsearch on Node 3:

```bash
systemctl start elasticsearch
```

## Testing Elasticsearch Cluster Health

Reset Elasticsearch password if needed:

```bash
/usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic -i
```

Check cluster status:

```bash
curl -k -u elastic:elastic https://localhost:9200/_cat/nodes?pretty
```

Example output:

```plaintext
46.62.x.x 28 97 68 0.75 0.22 0.07 cdfhilmrstw - es-node3
46.62.x.x 27 95 59 0.83 0.24 0.08 cdfhilmrstw - es-node2
192.168.122.2 17 92  1 0.00 0.07 0.07 cdfhilmrstw * es-node1
```

The asterisk `*` indicates the master node (Node 1).

## Firewall Configuration

Secure Elasticsearch nodes by restricting internet access, except SSH (port 22):

```bash
hcloud firewall create --name elasticsearch
hcloud firewall apply-to-resource --type server --server es-node1 elasticsearch
hcloud firewall apply-to-resource --type server --server es-node2 elasticsearch
hcloud firewall apply-to-resource --type server --server es-node3 elasticsearch
hcloud firewall add-rule --direction in --protocol tcp --port 22 elasticsearch
```

Your secure Elasticsearch cluster is now set up and ready for use.