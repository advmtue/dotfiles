#!/bin/bash

# Global Variables
##################################################

fg="#BDBDBD"
fg_sound="#F0C674"


# General Getter Functions
##################################################

# Time and Date
Clock() {
    echo "$(date '+%a %d-%m-%Y %I:%M %p')"
}

# Current playing track info
Music() {
    echo "$($HOME'/.config/lemonbar/cmus.sh')"
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
        bar=$bar"%{l}%{F$fg_sound} $line:$vol% %{F-}"
    else
        bar=$bar"%{l}%{F$fg_sound} MUTE %{F-}"
    fi

    # Music Info
    musicInfo="$(Music)"
    if [ -n "$musicInfo" ];
    then
        bar=$bar"%{F$fg} $musicInfo%{F-}"
    fi

    # Local IP
    localip="$(LocalIP)"
    bar="$bar%{r}%{F#5e8d87} $localip%{F-} | "

    # External IP
    #   Not important
    #   Only need to know if VPN up
    #ipadd="$(IP)"
    VPN="$(VPNRunning)"
    vpn_info="%{F#E0243A}Local"
    if [ $VPN == 1 ]
    then
        vpn_info="%{F#3BCC5D}Online"
    fi
    bar="$bar$vpn_info"

    # Time and Date
    clock="$(Clock)"
    bar=$bar"%{F$fg} | $clock %{F-}"

    # Workspaces
    bar="$bar$(Workspaces)"

    # Print that Sucka
    echo "$bar %{S1} $bar"
    sleep 1
done
