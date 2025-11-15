```bash
web_base                                 1.1.0                 79d26460b2f6   7 hours ago    152MB
jwilder/nginx-proxy                      latest                4e68010bd2c2   13 hours ago   172MB
jrcs/letsencrypt-nginx-proxy-companion   latest                7a6a0cb24375   6 days ago     48.4MB
srcs-adminer                             latest                d5c47055c9f7   10 days ago    118MB
phpmyadmin                               5.2.3                 ee6c7d7460b5   2 weeks ago    575MB
wordpress                                6.8.3-php8.3-apache   7332768c717f   3 weeks ago    734MB
mariadb                                  10.11                 bc52d24721da   2 months ago   327MB
```

## 2.- Guardar las imagenes en fichero .tar

```bash
docker save web_base:1.1.0 -o web_base_1.1.0.tar
docker save wordpress:6.8.3-php8.3-apache -o wordpress_6.8.3_php8.3_apache.tar
docker save phpmyadmin:5.2.3 -o phpmyadmin_5.2.3.tar
docker save mariadb:10.11 -o mariadb_10.11.tar
docker save jwilder/nginx-proxy -o nginx-proxy.tar
docker save jrcs/letsencrypt-nginx-proxy-companion -o letsencrypt.tar
```
## 3.- Empaquetar en tar.gz

```bash
tar -czf docker_images_backup.tar.gz *.tar
```

## 4.- Cargar imagenes en el nuevo servidor

```bash
tar -xzf docker_images_backup.tar.gz

docker load -i web_base_1.1.0.tar
docker load -i wordpress_6.8.3_php8.3_apache.tar
docker load -i phpmyadmin_5.2.3.tar
docker load -i mariadb_10.11.tar
docker load -i nginx-proxy.tar
docker load -i letsencrypt.tar
```

# Ansible

sudo apt remove ansible

sudo apt install python3-venv -y

install pyenv

python3 -m pip install ansible

python3 -m pip install --upgrade ansible

ansible-galaxy collection install community.docker

***Ansible**

ansible-doc -l

***/etc/host***
Editar el fichero y coner los nombre e IP de los host

***File hosts-control***
Listado con las maquinas a controlar

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