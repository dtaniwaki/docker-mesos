# docker-mesos

## Build Docker images

```sh
docker build --build-arg=MESOS_VERSION=1.4.0-2.0.1 mesos-master
docker build --build-arg=MESOS_VERSION=1.4.0-2.0.1 mesos-slave
docker build --build-arg=MARATHON_VERSION=1.5.1 marathon
```
