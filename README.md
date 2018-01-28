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


### Encrypt files in device

[https://www.veracrypt.fr/en/Home.html](https://www.veracrypt.fr/en/Home.html)


#### Find strings in files
For Windows
```
findstr /spin /c:"find in text" C:\<path>
```

For linux
```
grep -Riln 'Text to find' /<path>
```

grep -rnw '/path/to/somewhere/' -e 'pattern'

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




#### Ecexute command on a file matching pattern
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

