#!/bin/bash


if [[ $EUID -ne 0 ]];
then
    echo "This script must be run as root"
    exit 1
fi


if [[ "$1" == "on" ]];
then
    systemctl start vpn.service
    ufw enable
    systemctl start transmission.service
elif [[ "$1" == "off" ]];
then
    systemctl stop transmission.service
    systemctl stop vpn.service
    ufw disable
else
    echo "Invalid command entered, try 'vpn on' or 'vpn off'"
fi