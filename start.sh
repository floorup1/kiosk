#!/bin/bash
apt --fix-broken install -y
apt update
apt full-upgrade -y
apt autoremove
apt install acpid mc pcmanfm openbox lightdm curl git ansible cups -y
