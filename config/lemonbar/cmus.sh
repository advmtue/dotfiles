#!/bin/bash

fg_pause="#5C5C5C"
info="$(cmus-remote -C status)"

if [[ $(cmus-remote -C status) ]];
then
    curStatus="$(echo $info | grep -m 1 status)"
    curStatus="$(echo $curStatus | grep -oP '(playing|paused|stopped)')"

    if [ "$curStatus" == "stopped" ];
    then
        echo "Nothing Playing"
    else
        suffix=$()

        if [ "$curStatus" == "paused" ];
        then
            suffix=" - Paused"
        fi

        raw_title="$(cmus-remote -Q | grep 'tag title')"
        raw_artist="$(cmus-remote -Q | grep 'tag artist')"

        title="$(echo $raw_title | grep -oP 'tag title \K(.*)')"
        artist="$(echo $raw_artist | grep -oP 'tag artist \K(.*)')"

        echo "'$title' - $artist%{F$fg_pause}$suffix"
    fi
fi
