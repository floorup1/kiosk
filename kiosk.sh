#!/bin/bash
sudo apt-get update -y
sudo apt-get upgrade -y
sudo rm -rf /home/kiosk-user/share/*
sudo rm -rf /home/kiosk-user/Downloads/*
sudo rm -rf /home/kiosk-user/Загрузки/*
xset -dpms
xset s off
openbox-session &
start-pulseaudio-x11

while true; do
K1=$(grep -c "account required pam_time.so" /etc/pam.d/login)
if [ "$K1" -eq "0" ]; then
	sudo sh -c "echo 'account required pam_time.so' >> /etc/pam.d/login"
fi
K2=$(grep -c "*;*;*;MoTuThFr0700-1900|We0700-2000|Sa0700-1600" /etc/security/time.conf)
if [ "$K2" -eq "0" ]; then
	sudo sh -c "echo '*;*;*;MoTuThFr0700-1900|We0700-2000|Sa0700-1600' >> /etc/security/time.conf"
fi
sudo curl -o /etc/chromium/policies/managed/policy.json https://raw.githubusercontent.com/floorup1/kiosk/master/policy.json
sudo curl -o /opt/kiosk.sh https://raw.githubusercontent.com/floorup1/kiosk/master/kiosk.sh
sudo curl -o /etc/sudoers https://raw.githubusercontent.com/floorup1/kiosk/master/sudoers
sudo curl -o /opt/schedule.cronjob https://raw.githubusercontent.com/floorup1/kiosk/master/schedule.cronjob
sudo crontab /opt/schedule.cronjob
rm -rf /home/kiosk-user/.config/chromium/*
rm -rf /home/kiosk-user/.cache/chromium/*
if [ -d $HOME/startpage ] ; then
cd $HOME/startpage
git pull
cd $HOME
else
cd $HOME
git clone https://github.com/floorup1/startpage.git
fi
chromium --start-maximized 'file:///home/kiosk-user/startpage/start.html'
done
