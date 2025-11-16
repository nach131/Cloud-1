
# Cloud-1 - Automated Deployment of Inception  
**42 Barcelona** | *nmota-bu* | Version: **7.3**

> **"There is no cloud, it's just someone else's computer."**

---

## Overview

This project automates the **full deployment** of a **multi-service WordPress stack** using **Docker containers** and **Ansible orchestration**, meeting **100% of the Cloud-1 subject requirements**.

Deployed services:
- **WordPress** (`wordpress.tudominio.com`)
- **PHPMyAdmin** (`phpmyadmin.tudominio.com`)
- **MariaDB** (internal, secure)
- **NASA static site** (`nasa.tudominio.com`) – *extra demo*
- **Reverse Proxy + Automatic TLS** (Let's Encrypt)
- **Log rotation** (custom container)

---

## Architecture

```
[Client] → HTTPS (443) → [nginx-proxy + letsencrypt]
                             │
                ┌────────────┴────────────┐
                ▼                         ▼
        wordpress.tudominio.com    phpmyadmin.tudominio.com
                │                         │
           [WordPress]               [PHPMyAdmin]
                │                         │
                └───────────┬─────────────┘
                            ▼
                       [MariaDB]
```

- **1 process = 1 container**
- **Internal Docker network**: `cloud`
- **No direct DB access from internet**
- **All data persisted via bind mounts**

---

## Requirements Met (Mandatory Part)

| Requirement | Status | Implementation |
|-----------|--------|--------------|
| Fully automated deployment | Done | `ansible-playbook deploy_stack.yml` |
| Functional WordPress site | Done | `wordpress:6.8.3-php8.3-apache` |
| Auto-restart on reboot | Done | `restart: always` / `unless-stopped` |
| Data persistence | Done | `${TOMA}/data/mysql`, `${TOMA}/data/wordpress` |
| Deploy on multiple servers | Done | Ansible + inventory (`-l cloud2`) |
| Ubuntu 20.04 + SSH + Python only | Done | Docker installed via playbook |
| 1 container per process | Done | 6+ isolated services |
| Secure public access | Done | DB not exposed, internal network |
| docker-compose.yml | Done | `srcs/docker-compose.yml` |
| TLS support | Done | Let's Encrypt (staging → prod) |
| URL-based routing | Done | `VIRTUAL_HOST` per service |

---

## Directory Structure

```
Cloud-1/
├── deploy_stack.yml          # Ansible playbook
├── hosts-control             # Inventory (example)
├── vars.yml                  # Variables (use vault in prod)
├── env.j2                    # .env template
├── data.tar.gz               # Initial data (WP files, NASA site)
├── docker_images_backup.tar.gz # Pre-built images
└── srcs/
    └── docker-compose.yml
    └── requirements/
        ├── web/
        └── logrotate/
```

---

## Prerequisites

### Target Server
- **OS**: Ubuntu 20.04 LTS
- **Access**: SSH with user `nacho` (or configurable)
- **Python**: Installed (for Ansible)

### Control Node (your PC)
```bash
ansible>=2.10
ssh-keygen (for passwordless login)
```

---

## Deployment (One Command)

```bash
# From control node
ansible-playbook -i hosts-control deploy_stack.yml --ask-become-pass --vault-password-file=.vault_pass
```

> **Parallel deployment**:
```bash
ansible-playbook -i hosts-control deploy_stack.yml -l cloud2,cloud3 --ask-become-pass
```

## Generar una deploy key

```sh
ssh-keygen -t ed25519 -C "deploy key para repo X" -f ~/.ssh/deploy_key_repoX
```
### 1.- Dar permisos 
```sh
chmod 600 ~/.ssh/deploy_key_cloud
chmod 644 ~/.ssh/deploy_key_cloud.pub
```
### 1.2- Cargar las claves en ssh-agent
```sh
chmod 600 ~/.ssh/deploy_key_cloud
chmod 644 ~/.ssh/deploy_key_cloud.pub
```
comprobar que las claves estan cargad
```sh
ssh-add -l

256 SHA256:xxxxxxx deploy_key_cloud (ED25519)
```

### 1.3- Editar archivo configuracion SSH
```sh
vim ~/.ssh/config

Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/deploy_key_cloud
    IdentitiesOnly yes
```

### 1.4- Verificar la conexión
```sh
ssh -T git@github.com
```

### Añadir la key a Github para deploy

Eso deverias de saberlo


## Services & Domains

| Service | URL | HTTPS |
|-------|-----|-------|
| WordPress | `https://tudominio.com` | Yes |
| PHPMyAdmin | `https://phpmyadmin.tudominio.com` | Yes |
| NASA Site | `https://nasa.tudominio.com` | Yes |

> **Change domain**: Edit `DOMAIN` in `.env` or `vars.yml`

---

## Security

- Database **not exposed** (`no ports:`)
- SSH access only
- `.env` file: `mode: 0600`
- No secrets in Git
- TLS via Let's Encrypt (auto-renew)

---

## Persistence & Backup

All data is stored in:
```
${TOMA}/data/
├── mysql/        → MariaDB
├── wordpress/    → WP files
├── certs/        → TLS certs
├── nasa/         → Static site
└── logs/
```

> Survives container deletion, server reboot, or redeploy.

---

## Custom Features

| Feature | Description |
|-------|-----------|
| **Offline deployment** | Pre-loaded images via `docker load` |
| **Log rotation** | Dedicated `logrotate` container |
| **Multi-site ready** | Add new `VIRTUAL_HOST` → new site |
| **Zero downtime** | Proxy handles reloads gracefully |

---

## Switching to Production TLS

Edit `srcs/docker-compose.yml`:
```yaml
ACME_CA_URI: https://acme-v02.api.letsencrypt.org/directory
```

Then:
```bash
docker-compose down && docker-compose up -d
```

---

## Testing & Verification

```bash
# Check containers
docker ps

# Test HTTPS
curl -I https://tudominio.com

# Test subdomains
curl -H "Host: phpmyadmin.tudominio.com" http://YOUR_IP

# Reboot test
sudo reboot
# → Wait 2 min → access site → data intact
```

## Parallel Deployment (Multiple Servers)

```bash
# Desplegar en cloud1 y cloud2 al mismo tiempo
ansible-playbook -i hosts-control deploy_stack.yml -l cloud1,cloud2 --ask-become-pass

---


