# `vi` vs `visudo`

`visudo` is a special program to modify the file `/etc/sudoers`. If this file is modified with 
a plain editor and the syntax is not correct and saved. The command `sudo` will probably stop
working, and since `/etc/sudoers` is only modifiable by root, unless you have another way of
gainig root access.

Additionally it ensures that the edits to the sudoers file will be atomic. This protects 
multiple simultaneous edits.

There are other programm which helps in colliding edits to a file:`sudoedit
