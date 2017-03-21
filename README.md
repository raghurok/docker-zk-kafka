## Synopsis

Docker build file to install Kafka and Zookeeper over a Ubuntu image

## Motivation

There are bunch of Docker build files out there that has either Ubuntu, Kafka, or Zookeeper but not combination of all three

## Installation

In the directory with Dockerfile, build the docker image

```
docker build -t docker-zk-kafka:latest .
```

Run the docker image
```
docker run --name kafkanew -dit -p 2181:2181 -p 9092:9092 --env ADVERTISED_HOST=localhost --env ADVERTISED_PORT=9092 docker-zk-kafka
```

To tty into docker container, run
```
docker exec -it <HASH OF CONTAINER> /bin/bash
```
