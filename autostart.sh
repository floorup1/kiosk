#!/bin/bash
cd $HOME
apt update
apt --fix-broken install -y
apt update
apt full-upgrade -y
apt autoremove -y
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
