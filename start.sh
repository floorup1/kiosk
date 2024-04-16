#!/bin/bash
apt --fix-broken install -y
apt update
apt full-upgrade -y
apt autoremove
apt install samba auditd 