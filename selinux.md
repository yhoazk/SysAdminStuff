# SELinux

Originaly developed by the NSA and released in 2000.

The flag `-Z` is present in several commands, this flag shows the SELinux
properties.

The SELinux properties are part of the file/directory and is part of the 
file system in some cases.




## DAC vs MAC

### Discretionary Access Control: 

Users have the ability (discretion) to change permissions on their own files.
A user can `chmod +rwx` his home and nothing will stop them, as nothing will
stop other processes from acessing the contents of his home directory.

The `root` user ins omnipotent.

### Mandatory Access Control:

On mandatory acess control system, there is a policy which is administratively
set and fixed.

Even if the DAC is changed settings on the home directory, if there is a policy
which prevents another user or process from acessing it will not be possible.


## Policies

The policies can be very fine grained, policies can be set to determine Access
between:

- Users
- Files
- Directories 
- Memory
- Sockets
- tcp/udp ports
- etc...

In general there are two polices:

* Targeted
    - Only targeted processes are protected by SELinux
* mls (multi-level / multi-category security)
    - Only used in big organizations


## How does it works

The policy being used is in `/etc/selinux/config` which is symlinked to 
`/etc/sysconfig/selinux` and check the status with `/usr/sbin/sestatus`
also via `/usr/sbin/getenforce`

## Labeling 

Files, processes, ports, etc are all labeled with SELinux context. For files
and directories, these labels are stored as extended attributes in the filesystem

For processes, ports, network interfacs, etc. The kernel manages these labels.
Labels are in format `user:role:type:level(optional)` the user, role or level
are mostly used in MLS systems which is more advaned implementation of linux.
What is important is the type.

Many commands support the argument `-Z`

- `ls -Z`
- `id -Z`
- `ps -Z`
- `netstat -Z`

The `-Z` can create and modify files an contexts as well:
`cp -Z` and `mkdir -Z` there are other tools like `chcon` or `restorecon` to
change the context of a file

Contexts are set when files are created, based on their parent dirs contexts.
RPMs can set contexts as part of installation.

The login process sets the default context 

## Type enforcement

Type enforcement is the part of the policy that says a process running with
the label `httpd_t` can have access to a file labeled `httpd_config_t`

## Booleans

Booleans are just off/onn settings for SELinux.
From simple stiff like "do we allow the ftp server access the home dir?
to more esoteric stuff like "httpd can use mod_auth_ntlm_winbind" 

To see the booleans run `getsebool -a` or look at the booleans under
`/etc/selinux/targeted/modules/active/booleans.local`


## Tips

Install `setroubleshoot` and `setroubleshoot-server` thy drag a bunch of
tools to help and fix SELinux issues.

Also try to restart `auditd` after install.

Check `journalctl -b -0` to find issues related with SELinux 

In the case that a file has the incorrect context and then is not accessible
the context can be changed with the command `chcon`. For the type 
`chcon -t type_t file` if we have a file which is know to have the correct
settings use the command `chcon --reference /var/www/html /var/www/html/index.html`

Or even simpler change the context of the complete directory with `restorecon -vR /var/www/html`
which sets the same context for every file in that dir 

The contexts are stored in `/etc/selinux/targeted/contexts/files/file_contexts` and other
files in that directory to determine what a file or directory's context should be.
Do not modify this file directly, the changes will be lost

To change the context with which files will be restored or created in a directory
and below we need to use regex to set that for example to set the context
`httpd_sys_content_t` to everything below `/foo` use

```
semanage fcontext -a -t httpd_sys_content_t "/foo(/.*)?"
```

Or if we want to use a directory as a reference of how the flags should look like:

```
semanage fcontext -a -e /var/www/html /foo
# run the restore con to apply the  changes
restorecon -vR /foo
```


# Creating policy modules  

The permisive mode in SELinux allows the operations, but any violation is logged.
This is useful to avoid the "one-off" problem and solve all the problems using a
policy. Once the application is run and all the allowed operations are done
SELinux will create an alert with a message.

```
$ sealert -l <hash>
...
...
**** Plugin catch all (100 conficence) suggest *****
If you believe that httpd should be allowed name_connect access on the tcp_socket
by defaul. 
Then you should report this as a bug. You can generate a local policy to allow
this acess
Do:
# grep httpd /var/logaudit/audit.log | audit2allow -M mypol
```

- - - 
For example the apache web server has a binary in /usr/sbin when looked in 
the concept of SELinux the type is `httpd_exec_t`

```
# ls -lZ /usr/sbin/httpd
-rwxr-xr-x 1 root root system_u:objcet_r:httpd_exec_t:s0 53688 Jan 4 00:12 /usr/sbin/httpd
```

Now for the server configuration directory
```
# ls -dZ /etc/httpd
system_u:object_r:httpd_config_t:s0 /etc/httpd/
```

Now for the log file
```
# ls -dZ /var/log/httpd
system_u:object_r:httpd_log_t:s0 /var/log/httpd
```

Where the content of the site will be stored:

```
# ls -dZ /var/www/html/
system_u:object_r:httpd_content_t:s0 /var/www/html/
```

When the process is run, the process is labeled `httpd_t`

```
# ps axZ | grep [h]ttpd
system_u:system_r:httpd:t:s0 1212 ? Ss 0:01 /usr/sbin/httpd
```

Also `netstat -tnlpZ` to show the ports and the SELinux label.
