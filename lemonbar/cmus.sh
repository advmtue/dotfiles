#!/bin/bash

info="$(cmus-remote -C status)"

if [[ $(cmus-remote -C status) ]];
then
    curStatus="$(echo $info | grep -m 1 status)"
    curStatus="$(echo $curStatus | grep -oP '(playing|paused|stopped)')"

    if [ "$curStatus" == "stopped" ];
    then
        echo "- Stopped -"
    else
        prefix=$()

        if [ "$curStatus" == "paused" ];
        then
            prefix="Paused: "
        fi

        raw_title="$(cmus-remote -Q | grep 'tag title')"
        raw_artist="$(cmus-remote -Q | grep 'tag artist')"

        title="$(echo $raw_title | grep -oP 'tag title \K(.*)')"
        artist="$(echo $raw_artist | grep -oP 'tag artist \K(.*)')"

        echo "$prefix'$title' by $artist"
    fi
fi
