# SysAdminStuff
Linux and windows cofigurations snippets

#### Linux 

## Mount a `LVM` in linux.

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
grep -Riln "Text to find" /<path>
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




## Create self cointained installation packages

