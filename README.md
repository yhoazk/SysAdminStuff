# SysAdminStuff
Linux and windows cofigurations snippets

#### Linux

## [Mount a `LVM` in linux.](http://www.digitage.co.uk/digitage/library/linux/mounting-external-lvm-disk-in-linux)
  - Connect the drive
  - run the command `lvm`
    - Inside the `lvm` terminal
    - `pvscan` <- (note the PV name)
    - `lvscan` <- (note the LV names)
    - `lvchange -ay /dev/{pv-name-here}` eg ` lvchange -ay /dev/fedora_a/home`
  - Now mount the dive with that name: `sudo mount /dev/fedora_a/home /tmp/fed24/`
  - Here the drive is ready for use in `/tmp/fed24`

  To remove the disk:

  - umount /mnt
  - lvm
    - lvchange -an /dev/{pv-name-here}
### Max partitions for MMC

The linux kernel defines the number of partitios per MMC block device to be `CONFIG_MMC_BLOCK_MINORS`.
This defines the number of minors per block device. One is needed for every partition on the disk,
plus one for the whole disk. Number of total MMC minors is 256, so your number of supported block devices
will be limited by 256 divided by `CONFIG_MMC_BLOCK_MINORS`. Default is 8 to be backwards compatible with
previous hardwired device numbering.

[src](https://cateee.net/lkddb/web-lkddb/MMC_BLOCK_MINORS.html)

#### Commands:
`pvs`:
     pvs — report information about physical volumes

`lvdisplay`:
    lvdisplay — display attributes of a logical volume


To mount use the regular procedure:

1. Create a directory
    `mkdir HD_Laptopo`
2. Mount as a regular partion
    `mount mount /dev/vg_<host>/lv_home ./HD_Laptopo`

#### Command line open image from console for gnome:
`eog <path to image>`

#### Get disply settings in console:
`xdpyinfo`

Get the display size:
`xdpyinfo | grep dim`

#### Call the configured service to open a specific file:
`xdg-open <path to file>


## Windows:
#### [Change the prompt in cmd](https://www.microsoft.com/resources/documentation/windows/xp/all/proddocs/en-us/prompt.mspx?mfr=true)
```
prompt $$
```
### Go to sleep:
```
rundll32.exe powrprof.dll,SetSuspendState 0,1,0
```
#### Share a location:
`net share <share_name>=<full path> /GRANT:<user>,[READ | CHANGE | FULL]`

#### Look what is being shared:
`net share`


### Discover connected devices in the network
```
ping 192.168.1.255
arp -n
```
### add user to sudoers grp

```
sudo usermod -a -G sudo <user>
```

### Create and user
Use `adduser`, its a front end for the more low-level `useradd`.
`adduser` creates the `$HOME` for the in-creation user, while `useradd` does not.

### Encrypt files in device

[https://www.veracrypt.fr/en/Home.html](https://www.veracrypt.fr/en/Home.html)


#### Find strings in files
##### For Windows
```
findstr /spin /c:"find in text" [files]
```
* `s`: recursive
* `p`: skip non-printable chars
* `i`: case insensitive
* `n`: Print line numbers
* `/c:`: String to look up
* `[files]`: a regex for the file name e.g.: `c_*.h`

##### For linux
```
grep -Riln 'Text to find' /<path>
```

##### Chain grep

Instead of chainig grep calls with pipes, use the next option.

```
grep -v -e <regexa> -e <regexb> -e <regexc> -e <regexd>...
```

Other option is to enable the flag `-E`.

```
grep -Ev '(regexa|regexb|regexc|...)'
```

Or use a file which contains all the patters, one per line.

```
grep -v -f patterns.txt
```

```
grep -rnw '/path/to/somewhere/' -e 'pattern'
```
    -r or -R is recursive,
    -n is line number, and
    -w stands for match the whole word.
    -l (lower-case L) can be added to just give the file name of matching files.

Along with these, --exclude, --include, --exclude-dir flags could be used for efficient searching:

    This will only search through those files which have .c or .h extensions:

    grep --include=\*.{c,h} -rnw '/path/to/somewhere/' -e "pattern"

    This will exclude searching all the files ending with .o extension:

    grep --exclude=*.o -rnw '/path/to/somewhere/' -e "pattern"

    For directories it's possible to exclude a particular directory(ies) through --exclude-dir parameter. For example, this will exclude the dirs dir1/, dir2/ and all of them matching *.dst/:

    grep --exclude-dir={dir1,dir2,*.dst} -rnw '/path/to/somewhere/' -e "pattern"




#### Execute command on a file matching pattern
```
find -name "*.swp" - exec rm {} ';' # The command must be terminated with ';' or '\;'
```


### Complicated way to write files when there's no editor.

```
$ cat > filename.txt
write stuff
other stuff
and so on
^D
```
Done


##### `setuid` and `setgid`

`setuid` and `setgid` are Unix access rights flags that allow users to run an executable with the permissions of the executable's owner or group respectively and to change behaviour in directories.

### Using `/etc/skel` (skel = skeleton?)

The `/etc/skel` is a directory used by the command `useradd` to create
the default settings in a new user's home directory.

```
roor@pc/etc/skel#ls -a
. .. .bashrc .profile
```

The settings for the command `useradd` can be changed by editing
`/etc/default/useradd`


## `wget` in windows

To get files available via http:
```
cmd > ps
:: in power shell is an alias for Invoke-WebRequest
wget https://www.example.com -OutFile out.html
:: for older PS versions
Invoke-WebRequest http://www.google.com/ -OutFile c:\google.html
```

As an alternative use curl, it needs to add more paramenters to control
the output which does not goes to the a file with the same name as wget:
```
curl <url> -o <filename>
```

To act the same as wget, add `{}` to the URL to create the filename or the
folder structure. e.g.:

```
curl http://example.com/{dir}/{file}.pdf -o '#1/#2.pdf'
```

This will create the file `dir/file.pdf` with the same name.

## Which `tty` is being used:
To know which tty device is currently in use, use the command `tty`
which returns the device being used.

As a side note is important for logging programs to check and adapt for
the case in which the print output is a tty and when a file, this to
take into account the buffering or pipe size. In the case of redirection
with pipe the default size for a pipe named or not is 4k. If the buffer
is not flushed some logs get lost in the pipe if not handled correctly.

### Modify IO buffer in the terminal

## The install command:
Install with non-sudo permisions in a `/` folder:
```
sudo install -d -o $(whoami) -g $(whoami) <folder_name>
```

## Virtualization vs Containers




## Create self cointained installation packages for linux/RH

## Path too long in windows

There are at least 2 possiblities:
### 1. The command `subst`
This command creates a virtual drive with the given path:
```
subst z: b:\user\betty\forms :: creates the z: virtual drive pointing to c:\user\betty\forms
subst z: \d :: delete the virtual drive
```
### 2. The [`\\?\`](https://reverseengineering.stackexchange.com/questions/3798/c-question-marks-in-paths)

https://msdn.microsoft.com/en-us/library/windows/desktop/aa365247(v=vs.85).aspx

### `procfs` vs `sysfs`

`sysfs` was designed to add structure to `sysproc` and provide a uniform way
to expose system information and control points to user-space from the kernel.
Now, the driver framework in the kernel automatically creates directories under
`/sys` when drivers are registered, based on the type and the values in their
data structures.

- `procfs` allowa arbitrary `file_operations`, `sysfs` is more restricted.
    - `procfs receives a file_operations struct, which contains function pointers that determine what happens to every file-based system call (open, read, mmap)
- While `sysfs` there is ony two methods `show` and `store` which linux uses to implement the open, close, read, write and lseek .

