#!/bin/bash
cat > /etc/apt/sources.list << EOF
deb http://deb.debian.org/debian/ bookworm main non-free-firmware
deb-src http://deb.debian.org/debian/ bookworm main non-free-firmware
deb http://security.debian.org/debian-security bookworm-security main non-free-firmware
deb-src http://security.debian.org/debian-security bookworm-security main non-free-firmware
# bookworm-updates, to get updates before a point release is made;
# see https://www.debian.org/doc/manuals/debian-reference/ch02.en.html#_updates_and_backports
deb http://deb.debian.org/debian/ bookworm-updates main non-free-firmware
deb-src http://deb.debian.org/debian/ bookworm-updates main non-free-firmware
EOF
mkdir -p 777 /home/kiosk-user/.config/openbox
chmod ugo+rw /home/kiosk-user/.config/openbox
apt --fix-broken install -y
apt update
apt full-upgrade -y
apt autoremove
apt install acpid mc pcmanfm openbox lightdm curl git ansible cups -y
