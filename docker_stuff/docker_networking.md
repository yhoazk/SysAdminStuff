# Docker Networking

By default Docker creates a network interface called `docker0` which is a
ethernet bridge interface davice. If when starting a container no 
network is specified, that container will be connected to the bridge `docker0`
and all traffic flows over the bridge to the docker daemon, which handles the
routing on behalf of the container.

The docker containers will have an IP within the range of the `docker0` bridge.

```
docker network ls
NETWORK ID       NAME     DRIVER
xxxxxxxxxxxx     none     null
yyyyyyyyyyyy     host     host
zzzzzzzzzzzz     bidge    bridge
```

## Create a network

If we want two containers to talk to each other we can set the `/etc/hosts` file
to resolve the name, but this has to be done in each container, and since the
all the containers connect to the `docker0` brindge this method is not secure.

In docker is possible to define a new bridge network.

```
$ docker network create intercont_net
wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww

$ docker network ls
NETWORK ID       NAME           DRIVER
wwwwwwwwwwww     intercont_net  bridge
xxxxxxxxxxxx     none           null
yyyyyyyyyyyy     host           host
zzzzzzzzzzzz     bidge          bridge
```

Then when running the container, we need to specify that the container should
be attached to a specific network with the flag `--net`.

```
docker run --net intercont_net <container>
```

With this, docker will automatically add the necesary inputs to the `/etc/hosts`
file so any domains get resolved correctly1.

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
