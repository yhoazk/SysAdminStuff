# Reset password Pi

To reset the password in the orange-pi with acces to the sd card.
- Mount sd card
- edit `/etc/shadow` for the user:
- the password should look like:

```
root:$6$ssssssssssssssss$xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx:11111:0:99999:7:::
```

This field is separated by `:`:

- `root`: user
- `$6`: Algorithm used to generate the password
- `$ssss..s`: Salt added to the encrypted password
- `$xxxx...xx`: Tha encrypted password:

This password can be generated with:

```
openssl passwd -<N> --salt <16 char random> <password>
```
where `N` is the algorithm to be used to generate the hash

For example, for salt: __0123456789abcdef__ and password: __password__

```
openssl passwd -6 --salt 0123456789abcdef password
$6$0123456789abcdef$xDR267KnEdmU47Tv58n3gNdiOagKeAfIkcMyR6onqwUh3VWY6KqolWZcf8h/S6vI3O1EuVVODhFyX8F.iTNDA0
```

or 

mkpasswrd



## Enable encrypted sni in firefox

windows

linux