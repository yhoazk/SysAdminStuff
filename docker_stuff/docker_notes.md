# Docker:

Clean the docker images even if docker thinks they are not there:

```
sudo sytemctl stop docker
sudo rm -rf /var/lib/docker
sudo sytemctl start docker
```

## Groups cannot find name for group ID

in this case the problem is because the permission was  not correclty
enabled for the user.

for docker a user must be created in the docker file, here is an example:

```
RUN useradd --shell /bin/bash --home-dir /workspace --create-home docker_user
USER docker_user
```

## Access denied in a volume directory

This is because even when the container is run in hte same pc the 
UIDs are diferent, then to the OS looks like a user from a different
computer is trying to access the files.

The quick and ditry trick is to disable the security in linux

```
su -c "setenfoce 0"
```
