# What is docker

Docker is an operating system level virtualization for developers and sysadmins.
It makes easier to create and deploy applications in an isolated environment.

## What is the difference with other virtualization tools



## The `Dockerfile`

A `Dokerfile` is a script that contains collections of commands and instructions
that will be automatically executed in sequence in the docker environment for
building a new docker image.


## Installing Docker

It is available from the `apt`, `yum` or `dnf` commands:

```
sudo dnf install docker.io
```

After the installation, start the docker service and enable it to start at boot
time:

```
systemctl start docker
systemctl enable docker
```
