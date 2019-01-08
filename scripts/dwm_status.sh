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
BATTERY=`acpi -b | cut -d " " -f 4`
BATTERY_PREFIX=" "
if [[ `cat /sys/class/power_supply/BAT0/status` == "Charging" ]]; then
	BATTERY_PREFIX=" "
fi
BT="$BATTERY_PREFIX$BATTERY"


# wanip
ip_status
WANIP=`cut -d ":" -f 1 /tmp/ip_status.log`
W=" $WANIP"


# timedate
DATE=`date "+%d-%m-%y %I:%M %p"`
D=" $DATE"


# Output
echo -e " $BL  $V  $BT  $W  $D "
