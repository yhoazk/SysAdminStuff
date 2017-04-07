# SysAdminStuff
Linux and windows cofigurations snippets



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


## Windows:

#### Share a location:
`net share <share_name>=<full path> /GRANT:<user>,[READ | CHANGE | FULL]`

#### Look what is being shared:
`net share`
