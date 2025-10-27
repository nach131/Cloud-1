web_base                                 1.1.0                 79d26460b2f6   7 hours ago    152MB
jwilder/nginx-proxy                      latest                4e68010bd2c2   13 hours ago   172MB
jrcs/letsencrypt-nginx-proxy-companion   latest                7a6a0cb24375   6 days ago     48.4MB
srcs-adminer                             latest                d5c47055c9f7   10 days ago    118MB
phpmyadmin                               5.2.3                 ee6c7d7460b5   2 weeks ago    575MB
wordpress                                6.8.3-php8.3-apache   7332768c717f   3 weeks ago    734MB
mariadb                                  10.11                 bc52d24721da   2 months ago   327MB

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


  