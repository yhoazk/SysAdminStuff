# Persistent names for device drivers

When connecting several USB-serial convertes, the linux kernel assigns a number
to them and creates a link in `/dev` the full path is something like:
`/dev/ttyUSB1` or `/dev/ttyUSB2`. It depends on the order in which the devices
are discovered the number they get assigned. Then often is difficult to 
automate tools that use that device.

Every USB device has a Vendor ID and a Product ID. This can be obtained with
```
$lsusb
Bus 002 Device 002: ID 0b95:1790 ASIX Electronics Corp. AX88179 Gigabit Ethernet
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 004: ID 8087:0a2b Intel Corp. 
Bus 001 Device 003: ID 10c4:ea60 Cygnal Integrated Products, Inc. CP210x UART Bridge / myAVR mySmartUSB light
Bus 001 Device 002: ID 0403:6001 Future Technology Devices International, Ltd FT232 USB-Serial (UART) IC
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```
In some cases, like FTDI chips, the vendor id and product id will be repeated.
To distunguish between them we need some other unique id. In this case we can
use the serial number. The serial number is printed by dmesgwhen its plugged
or we can obtain the same with:
```
$udevadm info -a -n /dev/ttyUSB1 | grep '{serial}' | head -n1
    ATTRS{serial}=="AI0480MH"
```
## UDEV Rules
With the serial number, vendor and device Ids we can create a UDEV rule that
will create a symbolic link with a fixed name each time the device is connected.
UDEV rules are usually separeted in many files in `/etc/udev/rules.d`. Create
a new file there and call it somethin like `99-usb-serial.rules`

And add the next rules into the file replacing the IDs with the corresponding
ones.

```
SUBSYSTEM=="tty", ATTRS{idVendor}=="10c4", ATTRS{idProduct}=="ea60", ATTRS{serial}="0001", SYMLINK+="power_supply",  MODE="0660", GROUP="dialout"
SUBSYSTEM=="tty", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", ATTRS{serial}="AI0483MN", SYMLINK+="serial_xpad",  MODE="0660", GROUP="dialout"
# or
ACTION=="add", SUBSYSTEM=="tty", \                  
  ENV{ID_SERIAL}=="FTDI_FT232R_USB_UART_AI0483MN", \
  ENV{ID_VENDOR}="FTDI",  \                         
  GROUP="dialout", MODE="0660",                     
  SYMLINK+="xpad_serial"                            
```

To get the infrmation use the next command:

```
udevadm info -q all /dev/ttyUSB1
P: /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.0/ttyUSB1/tty/ttyUSB1
N: ttyUSB1
S: serial/by-id/usb-FTDI_FT232R_USB_UART_AI0483MN-if00-port0
S: serial/by-path/pci-0000:00:14.0-usb-0:2:1.0-port0
E: DEVLINKS=/dev/serial/by-path/pci-0000:00:14.0-usb-0:2:1.0-port0 /dev/serial/by-id/usb-FTDI_FT232R_USB_UART_AI0483MN-if00-port0
E: DEVNAME=/dev/ttyUSB1
E: DEVPATH=/devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.0/ttyUSB1/tty/ttyUSB1
E: ID_BUS=usb
E: ID_MM_CANDIDATE=1
E: ID_MODEL=FT232R_USB_UART
E: ID_MODEL_ENC=FT232R\x20USB\x20UART
E: ID_MODEL_FROM_DATABASE=FT232 Serial (UART) IC
E: ID_MODEL_ID=6001
E: ID_PATH=pci-0000:00:14.0-usb-0:2:1.0
E: ID_PATH_TAG=pci-0000_00_14_0-usb-0_2_1_0
E: ID_PCI_CLASS_FROM_DATABASE=Serial bus controller
E: ID_PCI_INTERFACE_FROM_DATABASE=XHCI
E: ID_PCI_SUBCLASS_FROM_DATABASE=USB controller
E: ID_REVISION=0600
E: ID_SERIAL=FTDI_FT232R_USB_UART_AI0483MN
E: ID_SERIAL_SHORT=AI0483MN
E: ID_TYPE=generic
E: ID_USB_DRIVER=ftdi_sio
E: ID_USB_INTERFACES=:ffffff:
E: ID_USB_INTERFACE_NUM=00
E: ID_VENDOR=FTDI
E: ID_VENDOR_ENC=FTDI
E: ID_VENDOR_FROM_DATABASE=Future Technology Devices International, Ltd
E: ID_VENDOR_ID=0403
E: MAJOR=188
E: MINOR=1
E: SUBSYSTEM=tty
E: TAGS=:systemd:
E: USEC_INITIALIZED=3375683
```

An alternative is to use the already established path in `/dev/serial/by-id/usb-*`
