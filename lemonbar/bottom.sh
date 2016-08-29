#!/bin/bash

# Lemonbar workspaces configuration

# Global variables
##################################################

fg_active="#5F819D"
fg_normal="#FFFFFF"

ws_unspec="Unspecified"

ws[1]="</>"
ws[2]="Firefox"
ws[3]="$ws_unspec"
ws[4]="$ws_unspec"
ws[5]="$ws_unspec"
ws[6]="$ws_unspec"
ws[7]="$ws_unspec"
ws[8]="$ws_unspec"
ws[9]="CMUS"
ws[10]="IRC"


# General Functions
##################################################

Screen() {
    echo "$(echo "$2" | grep "$1")"
}

Tiles() {
    tiles="$()"

    for i in {1..10};
    do
        tileInfo="$(echo "$1" | grep '|num:'$i'|')"

        if [ "$tileInfo" ];
        then
            tile="%{F$fg_normal}$i: ${ws[$i]}%{F-}"

            if [ "$(echo $tileInfo | grep 'focused:True')" ]
            then
                tile="%{F$fg_active}$i: ${ws[$i]}%{F-}"
            fi

            if [ "$tiles" ];
            then
                tile=" | $tile"
            fi

            tiles="$tiles$tile"
        fi
    done

    echo "$tiles"
}


# Execute
##################################################

while true;
do
    workspaces="$(i3-msg -t get_workspaces | python ~/.config/lemonbar/workspaces.py)"

    left="$(Screen 'DVI-I-1' "$workspaces")"
    right="$(Screen 'HDMI-0' "$workspaces")"

    left_tiles="$(Tiles "$left")"
    right_tiles="$(Tiles "$right")"

    echo "%{S0}%{c} $left_tiles %{S1}%{c} $right_tiles"
done
