#!/bin/bash

cat > /etc/hosts << EOT
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
172.25.22.201 node01.uplooking.com node01
172.25.22.202 node02.uplooking.com node02
172.25.22.203 node03.uplooking.com node03
172.25.22.204 node04.uplooking.com node04
172.25.22.205 node05.uplooking.com node05
172.25.22.206 node06.uplooking.com node06
172.25.22.207 node07.uplooking.com node07
172.25.22.208 node08.uplooking.com node08
172.25.22.209 node09.uplooking.com node09
172.25.22.210 node10.uplooking.com node10
EOT

hostname node$1.uplooking.com

cat > /etc/sysconfig/network << EOT
NETWORKING=yes
HOSTNAME=$1.uplooking.com
EOT


IP=$(cat /etc/hosts |grep node$1 |cut -d"." -f4 |cut -d" " -f1)

cat > /etc/sysconfig/network-scripts/ifcfg-eth0 <<EOT
DEVICE=eth0
TYPE=Ethernet
ONBOOT=yes
ONBOOT=yes
IPADDR=172.25.22.$IP
NETMASK=255.255.255.0
GATEWAY=172.25.22.254
EOT


cat > /etc/sysconfig/network-scripts/ifcfg-eth1 <<EOT
DEVICE=eth1
TYPE=Ethernet
ONBOOT=yes
BOOTPROTO=none
IPADDR=192.168.122.$IP
NETMASK=255.255.255.0
EOT

mkdir -p /root/.ssh
echo "sh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDBTC60Vzqsh9dOffo534v9OSXhtSX0fe3djNzT0l2MZT72auwVDHeaiv0a4pVt02tSa9HD6Yrhq9B+XioGAbIcD4Znsi9ZL7Iy5JLK8lqDfMpEIC4iKLxQHH+3rY5ecaOaUiLnE6NF3AvjoqYbrWG/y1qBgnozysMkbgHYM+zdWaO32MtB85JXyjr8mHcOgjucbgHWKYoMRLZclYnEw+vtF6kUnFXkAMY6Rs5EYX6u3ap5HiWslbjXyN+kDQH8xo62ap1ha4cjv2KP4G3EoFCF4xVmsEy6o5lD1lA8VvbJx2mkET1l38cl+W5eXOL1fk2azQteGFjmQTxrWdPlweUR root@foundation22.ilt.example.com" > /root/.ssh/authorized_keys

reboot

