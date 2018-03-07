# Docker Networking

By default Docker creates a network interface called `docker0` which is a
ethernet bridge interface davice. If when starting a container no different
network is specified, that container will be connected to the bridge `docker0`
and all traffic flows over the bridge to the docker daemon, which handles the
routing on behalf of the container.

The docker containers will have an IP within the range of the `docker0` bridge.







- - -

Normally docker images do not contain IP tools like `ifconfig` or editors like
`nano`, `vi`, `pico`.

This commands can be run in the image or in the `Dockerfile` during the build.

For ubuntu images:


```
apt-get update && apt-get install -y net-tools
```

As the tools for networking could not be included, is possible to query docker
network settings with the next commands:

#### Gets the IP, GW, MAC,
```
docker inspect <container>
```

#### Gets the IP, GW, MAC,
```
docker inspect <container>
```

#### Networking configuration

```
docker network ls
docker network inspect 8ce4e9f1923f
```

https://github.com/docker/for-win/issues/221
