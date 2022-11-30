#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi
clear
apt update && apt upgrade -y
clear
read -p "Enter domain (it has to be pointed on this server via A record without CDN - Cloudflare option should be gray not orange) " domain
wget -P /root -N --no-check-certificate "https://raw.githubusercontent.com/therealaleph/v2ray-agent/master/install.sh" && chmod 700 /root/install.sh
( echo 1 ; echo 1; echo $domain; echo 1; echo n; echo; echo; echo; ) | bash /root/install.sh
( echo 18; echo 1; echo 11;)  | vasma
( echo 5; echo 1;) | vasma
