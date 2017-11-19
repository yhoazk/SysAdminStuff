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


#### Call the configured service to open a specific file:
`xdg-open <path to file>


## Windows:

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
