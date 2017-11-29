# Configure a distro to act as a kiosk

[.](https://unix.stackexchange.com/questions/30207/debian-based-system-only-one-gui-program-nothing-else)

The kiosk mode is when the OS only allows (normally) just one app to 
be run in the system. Leave the app is not allowed nor modify the env
unless trough the app.

1. Add a session file in `/usr/share/xsessions/metacity-session.desktop`
2. Create the file to be executed in this session `/usr/local/bin/metacity-session`
3. Create the user-specific config file `~/.metacity-session`. This file will
   be executed by the file added in the step 2. The contents thus shall be the 
   program to run in this mode.

### For Rasphberry PI

Creating a Debian Chromium Kiosk (PC or Raspberry PI)

  - download and install debian
    - PC x64 or i386 : download "standard" iso from debian.org
    - raspberry pi 2/3 : download "raspbian lite" from raspberryip.org
      - use Win32DiskImager to write img to SD card

  - after install use apt to install packages
apt install --no-install-recommends xorg openbox lightdm chromium pulseaudio
    - on raspberry pi chromium package is chromium-browser
    - installing packages is slow on raspberry, get a FAST SD card (class 10 or better)

  - configure lightdm for autologin
    - edit /etc/lightdm/lightdm.conf goto [SeatDefaults] section, uncomment "autologin-user"
[SeatDefaults]
autologin-user={USER}
    - {USER} is defined during debian installer for PC
    - {USER} is 'pi' for raspberry pi

  - configure openbox to start chromium automatically
    - edit /etc/xdg/openbox/autostart or create ~/.config/openbox/autostart and add these lines:
xset -dpms
xset s off
chromium --kiosk http://google.com
    - change google.com to whatever you need
    - the xset commands disable screen savers
    - on raspberry pi chromium is chromium-browser

  - to auto connect to Wifi
    - edit /etc/network/interfaces and write:
auto wlan0
iface wlan0 inet dhcp
  wpa-ssid {ssid}
  wpa-psk  {password}
    - replace {ssid} and {password} with your respective WiFi SSID and password
