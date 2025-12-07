## 1.- Configurar Server

```sh
useradd -m -s /bin/bash nacho
passwd nacho   # (solo si se quiere tener password local)
sudo usermod -aG sudo nacho

```
### 1.2. Crear directorios .ssh
```sh
mkdir -p /home/nacho/.ssh
touch /home/nacho/.ssh/authorized_keys
chmod 700 /home/nacho/.ssh
chmod 600 /home/nacho/.ssh/authorized_keys
chown -R nacho:nacho /home/nacho/.ssh
```

### 1.3 Añadir clave pública
*** Pegarla directamente ***
```sh
cat >> /home/nacho/.ssh/authorized_keys << EOF
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI...tu-clave-completa... tu-comentario
EOF
```
*** Copiarla desde host principal ***
```sh
ssh-copy-id -i ~/.ssh/id_ed25519.pub nacho@IP_DEL_SERVIDOR
```

### 1.4 Desactivar login por contraseña y por root en SSH
```sh
nano /etc/ssh/sshd_config

PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
ChallengeResponseAuthentication no
```

### 1.5 Reiniciar el servidor SSH
```sh
systemctl restart sshd
# o en algunos servidores:
systemctl restart ssh
```

```bash
web_base                                 1.1.0                 79d26460b2f6   7 hours ago    152MB
jwilder/nginx-proxy                      latest                4e68010bd2c2   13 hours ago   172MB
jrcs/letsencrypt-nginx-proxy-companion   latest                7a6a0cb24375   6 days ago     48.4MB
srcs-adminer                             latest                d5c47055c9f7   10 days ago    118MB
phpmyadmin                               5.2.3                 ee6c7d7460b5   2 weeks ago    575MB
wordpress                                6.8.3-php8.3-apache   7332768c717f   3 weeks ago    734MB
mariadb                                  10.11                 bc52d24721da   2 months ago   327MB
```

## 2.- Guardar las imagenes de Docker
```sh
docker save $(docker-compose -f docker-compose.yml config | grep 'image:' | awk '{print $2}') -o docker_images_backup.tar
```

## 2.1- COMPRIMIR PARA ENVIAR
```sh
gzip docker_images_backup.tar
```

## 2.2.- Cargar imagenes en el nuevo servidor

```bash
 docker load -i docker_images_backup.tar.gz
```

# Ansible
```sh
sudo apt remove ansible

sudo apt install python3-venv -y

python3 -m venv ansible-venv

source ansible-venv/bin/activate

python3 -m pip install ansible

python3 -m pip install --upgrade ansible

ansible-galaxy collection install community.docker
```

***Ansible**

ansible-doc -l

***/etc/host***
Editar el fichero y con los nombre e IP de los host

***File hosts-control***
Listado con las maquinas a controlar
hosts-control

## Hacer ping a todos los nodos
```sh
 ansible -i hosts-control all -m ping
```

## Ejecutar comando
```sh
ansible -i hosts-control all -m command -a "touch /home/nacho/tomate.txt"

ansible -i hosts-control cloud2 -m shell -a "echo 'mas' > /home/nacho/toma.txt"
```

```sh
ansible -i hosts-control all -m shell -a "cat /home/nacho/toma.txt"
cloud1 | CHANGED | rc=0 >>
dededededede:wq
cloud2 | CHANGED | rc=0 >>
```

### copiar carpeta a host
```sh
ansible -i hosts-control all -m copy -a "src=toma dest=/home/nacho"
```

### Borrar carpeta con sudo pondiendo password"
```sh
 ansible -i hosts-control cloud2 -m file -a "path=/home/nacho/Cloud-1 state=absent" -b --ask-become-pass 
```
### Buscar paquetes en ubuntu server
```sh
sudo apt search apache2 | less

```
## Instalado paquetes


# **Usando el módulo `apt`**

El módulo `apt` es la forma “Ansible way” de instalar paquetes en sistemas basados en Debian/Ubuntu.

Ejemplo: instalar `apache2` en todos los hosts:

```bash
ansible -i hosts-control all -b -m apt -a "name=apache2 state=present update_cache=yes"
```

Explicación:

* `-b` → usa sudo (necesario para instalar paquetes)
* `-m apt` → módulo de gestión de paquetes para Debian/Ubuntu
* `name=apache2` → paquete a instalar
* `state=present` → asegura que esté instalado
* `update_cache=yes` → actualiza la caché de paquetes antes de instalar

---

# **Instalar varios paquetes**

Si quieres instalar varios paquetes a la vez:

```bash
ansible -i hosts-control all -b -m apt -a "name='apache2 curl git' state=present update_cache=yes"
```

> Nota: los nombres se separan por espacios, pero van entre comillas.

---

# ✅ **Opcional — Usar playbook para mayor control**

Es más limpio y reutilizable con un playbook YAML:

```yaml
---
- name: Instalar paquetes en todos los hosts
  hosts: all
  become: yes
  tasks:
    - name: Instalar apache2 y utilidades
      apt:
        name:
          - apache2
          - curl
          - git
        state: present
        update_cache: yes
```

Ejecutar el playbook:

```bash
ansible-playbook -i hosts-control install_packages.yml
```

---


Comprobacion ip

dig nasa.cloud.enunpimpam.com +short

***Forzar renovacion certrs***

docker exec -it letsencrypt /app/force_renew

***Forzar renovacion un dominio***

docker exec -it letsencrypt certbot renew --cert-name midominio.com --force-renewal

***Comprobar certificados***

docker exec -it letsencrypt ls /etc/nginx/certs/mi_dominio.com



## Cifrar claves vars
```sh
ansible-vault encrypt vars.yml
```

## eliminar todas las entradas de CD-ROM:
```sh
sudo sed -i '/cdrom/d' /etc/apt/sources.list
```