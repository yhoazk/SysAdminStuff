# /etc/hosts a.k.a local DNS

**See man hosts**

This is a simple text file which associates IP addresses with host names,
ine line per IP address. For each host a single line shoulf be present
with the following format:
```
<IP_address> <canonical_hostname> [aliases...]
```

## Example

```
# This is a comment
127.0.0.1 localhost

127.0.1.1   thishost.mydomain.org thishost
192.168.1.44 foo.bar.baz  crappysite
```


