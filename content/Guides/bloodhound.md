---
tags:
  - guide
title: Installing Bloodhound
---
# Install Docker
```bash
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian bookworm stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list
```

```bash
curl -fsSL https://download.docker.com/linux/debian/gpg |
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```

```bash
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io
```


# Install&Run Bloodhound
```bash
curl -L https://ghst.ly/getbhce -o compose.yml
docker compose pull
docker compose up -d
```

After running `docker compose up` you will get a one-time password. You will use this to go to `localhost:8080` and log in as `admin`.