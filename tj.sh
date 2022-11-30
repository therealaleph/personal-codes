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
ufw allow 22,8080,8880,443,80,991,54321,2052,2082,2086,2095,2096/tcp && ufw allow 22,8080,8880,443,80,991,54321,2052,2082,2086,2095,2096/udp && ufw deny out from any to 10.0.0.0/8 && ufw deny out from any to 172.16.0.0/12 && ufw deny out from any to 192.168.0.0/16 && ufw deny out from any to 100.64.0.0/10 &&  ufw deny out from any to 198.18.0.0/15 && ufw deny out from any to 169.254.0.0/16
(echo y ) | ufw enable 
( echo 6; echo 10; echo 1; echo https://www.cloudflare.com;) | vasma 
