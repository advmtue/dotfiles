#!/bin/bash

fg_pause="#5C5C5C"
info="$(cmus-remote -C status)"

if [[ $info ]];
then
    curStatus=$(echo "$info" | grep -m 1 -oP '(?<=status\s)(.*)')

    if [ "$curStatus" == "stopped" ];
    then
        echo "Nothing Playing"
    else
        suffix=$()

        if [ "$curStatus" == "paused" ];
        then
            suffix=" - Paused"
        fi

        title=$(echo "$info" | grep -m 1 -oP '(?<=title\s)(.*)')
        artist=$(echo "$info" | grep -m 1 -oP '(?<=artist\s)(.*)')

        echo "'$title' - $artist%{F$fg_pause}$suffix"
    fi
fi
