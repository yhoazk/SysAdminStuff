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
