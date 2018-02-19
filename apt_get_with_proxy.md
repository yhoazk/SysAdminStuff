# Using apt-get behind a proxy or in docker:

it is needed to also add the proxy configuration to the `apt.conf` file,
which is normally not created in: `/etc/apt/`.

Add a Aquire for each of the protocols mapped:
```
Acquire::http::Proxy "http://user:passwdproxy.com:8080";
Acquire::https::Proxy "https://user:passwdproxy.com:8080";
```
