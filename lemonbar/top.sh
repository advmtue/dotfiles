#!/bin/bash

# Things that I need in the lemonbar:
#   VPN Status TODO

# Global Variables
##################################################

fg="#BDBDBD"
bg="-"


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
        "headphones") echo "Headphones";;
        "lineout") echo "Speakers";;
    esac
}

# IP Addresss
IP() {
    echo "$(dig +short myip.opendns.com @resolver1.opendns.com)"
}

VPNRunning() {
    echo "$(ps -aux | grep openvpn | grep root | wc -l)"
}


# Execution
##################################################
while true; do
    bar=$()

    # Left Side:
    #   Vol Volume() - Audioline()
    if [ "$(AudioEnabled)" == "on" ];
    then
        vol="$(Volume)"
        line="$(Audioline)"
        bar=$bar"%{l}%{F$fg}%{B$bg} $line:$vol% %{F-}%{B-}"
    else
        bar=$bar"%{l}%{F$fg}%{B$bg} Muted %{F-}%{B-}"
    fi

    ipadd="$(IP)"
    VPN="$(VPNRunning)"
    col="%{F#E0243A}"
    if [ $VPN == 1 ]
    then
        col="%{F#3BCC5D}"
    fi
    bar=$bar"$col$ipadd"

    # Music Info
    musicInfo="$(Music)"
    if [ -n "$musicInfo" ];
    then
        bar=$bar"%{c}%{F$fg}%{B$bg} $musicInfo %{F-}%{B-}"
    fi

    # Time and Date
    clock="$(Clock)"
    bar=$bar"%{r}%{F$fg}%{B$bg} $clock %{F-}%{B-}"

    # Print that Sucka
    echo "$bar %{S1} $bar"
    sleep 1
done
