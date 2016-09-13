#!/bin/bash

fg_paused="#5C5C5C"

status="$(mpc -f '{t:%title%}{a:%albumartist%}')"

activity="$(echo $status | grep -oP '\[\K(playing|paused)')"

if [[ "$activity" ]];
then
    suffix=$()
    #                                   Regex gives me a hardon
    title="$(echo $status | grep -oP '(?<=\{t\:)(.*?(?=\}))')"
    artist="$(echo $status | grep -oP '(?<=\{a\:)(.*?(?=\}))')"

    if [[ "$activity" == "paused" ]];
    then
        suffix=" - Paused";
    fi

    echo "[$title] - $artist%{F$fg_paused}$suffix"
fi
