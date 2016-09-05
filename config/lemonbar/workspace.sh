#!/bin/bash

# Lemonbar workspaces aggregation

# Global variables
##################################################

col_tile_focused="#5F819D"
col_tile_active="#FFFFFF"
col_tile_inactive="#3A3A3A"


# General Functions
##################################################

# Function used to grab workspaces from one screen
#   $1 = Bunch of workspaces
#   $2 = Name of output device to grep
Screen() {
    echo "$(echo "$2" | grep "$1")"
}

# Function used to create workspace string for a given screen
#   $1 = Workspaces on screen
Tiles() {
    tiles="$()"

    for i in {1..10};
    do
        # Get info for i-th workspace
        tileInfo="$(echo "$1" | grep '|num:'$i'|')"

        # Empty instantiation
        tile="$()"

        # If #workspace is active
        if [ "$tileInfo" ];
        then
            # Create a normal active number
            tile="%{F$col_tile_active}$i"

            # Check if focused
            if [ "$(echo $tileInfo | grep 'focused:True')" ]
            then
                # Change to focused active number
                #   and underline it
                tile="%{+u}%{F$col_tile_focused}$i"
            fi
        else
            # Inactive workspace
            tile="%{F$col_tile_inactive}$i"
        fi

        # If not first tile (tiles not empty)
        if [ "$tiles" ];
        then
            # Pad it
            tile="  $tile"
        fi

        tiles="$tiles$tile%{F-}%{B-}%{-u}"
    done

    echo "$tiles"
}


# Execute
##################################################

workspaces="$(i3-msg -t get_workspaces | python ~/.config/lemonbar/workspaces.py)"

left="$(Screen 'DVI-I-1' "$workspaces")"
right="$(Screen 'HDMI-0' "$workspaces")"

left_tiles="$(Tiles "$left")"
right_tiles="$(Tiles "$right")"

echo "%{S0}%{c} $left_tiles %{S1}%{c} $right_tiles"
