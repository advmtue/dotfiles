#!/bin/bash


if [[ $EUID -ne 0 ]];
then
    echo "This script must be run as root"
    exit 1
fi


if [[ "$1" == "on" ]];
then
    ufw enable
    systemctl start wg-quick@wg0
elif [[ "$1" == "off" ]];
then
    systemctl stop wg-quick@wg0
    ufw disable
else
    echo "Invalid command entered, try 'vpn on' or 'vpn off'"
fi
