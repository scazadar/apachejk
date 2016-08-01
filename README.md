# apache with mod_jk
## docker-compose example
```
apache:
  labels:
    traefik.frontend.rule: Host:xxx.xxx.com
    traefik.backend: xxx
  tty: true
  image: scazadar/apachejk
  links:
  - 'glassfish:'
  volumes:
  - /path/to/site.conf:/etc/apache2/sites-enabled/site.conf
  - /path/to/workers.properties:/etc/libapache2-mod-jk/workers.properties
  stdin_open: true
glassfish:
  ports:
  - 4848:4848/tcp
  - 8009/tcp
  labels:
    io.rancher.container.pull_image: always
  tty: true
  image: glassfish:4.0
  links:
  - 'mysql:'
  volumes:
  - /path/to/glassfish4/glassfish:/usr/local/glassfish4/glassfish
  stdin_open: true
mysql:
  environment:
    MYSQL_ROOT_PASSWORD: xxx
  labels:
    io.rancher.container.pull_image: always
  tty: true
  image: mysql
  volumes:
  - /path/to/mysql
  stdin_open: true
```
## workers.properties
```
worker.list=ajp13_worker
worker.ajp13_worker.port=8009
worker.ajp13_worker.host=glassfish
worker.ajp13_worker.type=ajp13
```

## site.conf
```
<VirtualHost *:80>
        ServerName xxx.xxx.com

        ServerAdmin webmaster@localhost
        JkMount /* ajp13_worker

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```
