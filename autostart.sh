#!/bin/bash
#mkdir -p 777 /home/kiosk-user/.config/openbox
#cat > /etc/apt/sources.list << EOF
#deb http://deb.debian.org/debian/ bookworm main non-free-firmware
#deb-src http://deb.debian.org/debian/ bookworm main non-free-firmware
#deb http://security.debian.org/debian-security bookworm-security main non-free-firmware
#deb-src http://security.debian.org/debian-security bookworm-security main non-free-firmware
# bookworm-updates, to get updates before a point release is made;
# see https://www.debian.org/doc/manuals/debian-reference/ch02.en.html#_updates_and_backports
#deb http://deb.debian.org/debian/ bookworm-updates main non-free-firmware
#deb-src http://deb.debian.org/debian/ bookworm-updates main non-free-firmware
#EOF
apt update
apt full-upgrade -y
apt install acpid mc pcmanfm openbox lightdm curl git ansible cups -y
curl -o $HOME/autostart.sh https://raw.githubusercontent.com/floorup1/kiosk/master/autostart.sh
curl -o $HOME/ans.sh https://raw.githubusercontent.com/floorup1/kiosk/master/ans.sh
curl -o /home/kiosk-user/.config/openbox/autostart https://raw.githubusercontent.com/floorup1/kiosk/master/autostart
curl -o /home/kiosk-user/.config/openbox/rc.xml https://raw.githubusercontent.com/floorup1/kiosk/master/rc.xml
chmod +x $HOME/autostart.sh
chmod +x $HOME/ans.sh
chmod ugo+rwx /home/kiosk-user/.config/openbox/autostart
chmod ugo+rw /home/kiosk-user/.config/openbox/rc.xml
curl -o $HOME/schedule.cronjob  https://raw.githubusercontent.com/floorup1/kiosk/master/schedule.cronjob
crontab $HOME/schedule.cronjob
if [ -d /etc/chromium/policies/managed ]; then
  curl -o /etc/chromium/policies/managed/policy.json https://raw.githubusercontent.com/floorup1/kiosk/master/policy.json
else
  mkdir -p /etc/chromium/policies/managed
  curl -o /etc/chromium/policies/managed/policy.json https://raw.githubusercontent.com/floorup1/kiosk/master/policy.json
fi
K1=$(grep -c "account required pam_time.so" /etc/pam.d/login)
if [ "$K1" -eq "0" ]; then
  sh -c "echo 'account required pam_time.so' >> /etc/pam.d/login"
fi
K2=$(grep -c "*;*;*;MoTuThFr0700-1900|We0700-2000|Sa0700-1600" /etc/security/time.conf)
if [ "$K2" -eq "0" ]; then
  sh -c "echo '*;*;*;MoTuThFr0700-1900|We0700-2000|Sa0700-1600' >> /etc/security/time.conf"
fi
