#!/bin/sh


# volume
## Deal with muted/unmuted
VOLUME="`pamixer --get-volume`%"
VOLUME_PREFIX=' '
if [[ `pamixer --get-mute` == "true" ]]; then
	VOLUME="MUTED"
	VOLUME_PREFIX=""
fi
V="$VOLUME_PREFIX$VOLUME"


# backlight
BACKLIGHT=`printf "%0.0f" $(xbacklight)`
BL="盛 $BACKLIGHT%"


# battery
BATTERY=`acpi -b | grep -Po "([0-9]{1,3}%)"`
BATTERY_PREFIX=" "
if [[ `cat /sys/class/power_supply/BAT0/status` == "Charging" ]]; then
	BATTERY_PREFIX=" "
fi
BT="$BATTERY_PREFIX$BATTERY"


# wanip
WANIP=`wanip`
[ -z $WANIP ] && WANIP="- no ip -"
W=" $WANIP"


# timedate
DATE=`date "+%d-%m-%y %I:%M %p"`
D=" $DATE"


# Output
O=" $BL  $V  $BT  $W  $D "
echo -e "$O"

if [[ $1 == "update" ]]; then
	xsetroot -name "$O";
fi
