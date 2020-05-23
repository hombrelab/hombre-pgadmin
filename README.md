# hombre-pgadmin4
![Docker Pulls](https://img.shields.io/docker/pulls/hombrelab/hombre-pgadmin4) ![Docker Image Version (latest by date)](https://img.shields.io/docker/v/hombrelab/hombre-pgadmin4) ![GitHub commit activity](https://img.shields.io/github/last-commit/hombrelab/hombre-pgadmin4)  

The [hombre-pgadmin4](https://hub.docker.com/repository/docker/hombrelab/hombre-pgadmin4) image is based on the [hombre-python](https://hub.docker.com/repository/docker/hombrelab/hombre-python) image and [pgAdmin 4 v4.20](https://www.pgadmin.org/).  
It is a customized Docker image for and by [@Hombrelab](me@hombrelab.com).

Deployment examples:

Command line
```shell script
docker run \
    --name pgadmin4 \
    --detach \
    --restart unless-stopped \
    --volume /home/data/pgadmin:/var/lib/pgadmin \
    --volume /etc/localtime:/etc/localtime:ro \
    --env PGADMIN_DEFAULT_EMAIL=me@hombrelab \
    --env PGADMIN_DEFAULT_PASSWORD=hombrelab \
    --publish 9999:80 \
    --expose 80 \
    hombrelab/hombre-pgadmin4
```
Docker Compose
```yaml
    pgadmin:
        container_name: pgadmin
        restart: unless-stopped
        image: hombrelab/hombre-pgadmin4
        volumes:
            - /home/data/pgadmin:/var/lib/pgadmin
            - /etc/localtime:/etc/localtime:ro
        environment:
            - PGADMIN_DEFAULT_EMAIL=me@hombrelab
            - PGADMIN_DEFAULT_PASSWORD=hombrelab
        ports:
            - 9999:80
        expose:
            - 80
```