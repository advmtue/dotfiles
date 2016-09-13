#!/bin/bash

# Global Variables
##################################################

col_text_light="#BDBDBD"
col_text_dark="#101010"

col_yellow="#F0C674"
col_yellow_dark="#BE9F63"


# General Getter Functions
##################################################

# Time and Date
Clock() {
    echo "$(date '+%a %d-%m-%Y %I:%M %p')"
}

# Current playing track info
Music() {
    #echo "$($HOME'/.config/lemonbar/cmus.sh')"
    echo "$($HOME'/.config/lemonbar/mpc.sh')"
}

# Volume of amixer Master
Volume() {
    echo "$(amixer sget Master | grep -oPm 1 '\[\K([0-9]{0,3})')"
}

# Mute status of amixer Master
AudioEnabled() {
    echo "$(amixer sget Master | grep -oPm 1 '\[\K(on|off)')"
}

# Active sink port
Audioline() {
    sinks="$(pactl list sinks)"
    active="$(echo $sinks | grep -oP 'Active Port: analog-output-\K(headphones|lineout)')"
    case "$active" in
        "headphones") echo "H";;
        "lineout") echo "S";;
    esac
}

# IP Addresss
#   This is really quite spammy
IP() {
    echo "$(dig +short myip.opendns.com @resolver1.opendns.com)"
}

LocalIP() {
    echo "$(ip addr list enp3s0 | grep -oP '(?<=inet\s)((?:[0-9]{1,3}\.?){4})')"
}

VPNRunning() {
    echo "$(ps -aux | grep openvpn | grep root | wc -l)"
}

Workspaces() {
    echo "$(~/.config/lemonbar/workspace.sh)"
}

# Execution
##################################################
while true; do
    bar=$()

    # Left Side:
    if [ "$(AudioEnabled)" == "on" ];
    then
        vol="$(Volume)"
        line="$(Audioline)"
        bar=$bar"%{l}%{B$col_yellow_dark}%{F$col_text_dark} $line:$vol% %{F-}%{B-}"
    else
        bar=$bar"%{l}%{B$col_yellow_dark}%{F$col_text_dark} MUTE %{F-}%{B-}"
    fi

    # Music Info
    musicInfo="$(Music)"
    if [ -n "$musicInfo" ];
    then
        bar=$bar"%{F$col_text_light} $musicInfo%{F-}"
    fi

    # Local IP and VPN Status
    #   Text = Local IP Address (IPV4)
    #   Green = VPN Running
    #   Red = VPN Down
    localip="$(LocalIP)"
    vpn_status="$(VPNRunning)"
    vpn_info="%{F#E0243A}"

    if [ $vpn_status == 1 ]
    then
        vpn_info="%{F#3BCC5D}"
    fi

    bar="$bar%{r}$vpn_info$localip%{F-}%{B-}"

    # Time and Date
    clock="$(Clock)"
    bar=$bar"%{F$col_text_light} | $clock %{F-}"

    # Workspaces
    ws="$(Workspaces)"

    # Print that Sucka
    echo "$bar%{S1}$bar$ws"
done
