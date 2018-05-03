# Setting a proxy

## Option 1

Add the following configuration in `/etc/sysconfig/docker`

```
export HTTPS_PROXY="https://username:password@proxy.server:port
export HTTP_PROXY="http://username:password@proxy.server:port
export FPS_PROXY="ftp://username:password@proxy.server:port
```


## Option 2

Create a drop-in:

```
mkdir /etc/systemd/system/docker.service.d
```

In that directory create a file `http-proxy.conf` with the content:
```
[Service]
Environment="HTTP_PROXY=http://user01:password@10.10.10.10:8080/"
Environment="HTTPS_PROXY=https://user01:password@10.10.10.10:8080/"
Environment="NO_PROXY= hostname.example.com,172.10.10.10"
```


* Then reload the daemons: `systemclt daemon-reload`
* And restart docker: `systemctl restart docker`

Then to verify that he configuration was loaded:
```
# systemctl show docker --property Environment
Environment=GOTRACEBACK=crash HTTP_PROXY=http://10.10.10.10:8080/ HTTPS_PROXY=http://10.10.10.10:8080/ NO_PROXY= hostname.example.com,172.10.10.10
```


https://stackoverflow.com/questions/22179301/how-do-you-run-apt-get-in-a-dockerfile-behind-a-proxy
