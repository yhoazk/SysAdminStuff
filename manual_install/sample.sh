#!/bin/bash

# Download GitKraken
wget https://release.gitkraken.com/linux/gitkraken-amd64.tar.gz

# copy the downloaded file into /opt directory
cp gitkraken-amd64.tar.gz /opt/gitkraken

cd /opt

# Extract the Kraken into /opt directory
tar -xvzf gitkraken-amd64.tar.gz

# Add gitkraken to PATH
echo "export PATH=\$PATH:/opt/gitkraken" >> ~/.bashrc
source ~/.bashrc

# Create gitkraken launcher icon
# download icon here: http://img.informer.com/icons_mac/png/128/422/422255.png
# or here: https://drive.google.com/file/d/0B-3KQ_ohu-RFVkJyS1Zfa2NLSVE/view
cp {your-image}.png /opt/gitkraken/

cd /usr/share/applications

touch gitkraken.desktop

vim gitkraken.desktop

# copy the following contents into gitkraken.desktop file:
[Desktop Entry]
Name=GitKraken
Comment=Git Flow
Exec=/opt/gitkraken/gitkraken
Icon=/opt/gitkraken/icon.png
Terminal=false
Type=Application
Encoding=UTF-8
Categories=Utility;Development;

# save it, and voilá!
