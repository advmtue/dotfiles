#!/bin/bash

# Screenshot
# scrot /tmp/screen.png
convert -size 4480x1440 xc:black /tmp/screen.png
# Make the screenshot low res and scale back up
# convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png

# Lock icon info
icon_info=$(file $HOME/.config/i3/lock.png | grep -o '[0-9]* x [0-9]*')
resX=$(echo $icon_info | cut -d ' ' -f 1)
resY=$(echo $icon_info | cut -d ' ' -f 3)

screen_info=$(xrandr | grep ' connected' | cut -f 3 -d ' ')

for screen in $screen_info;
do
    screenX=$(echo $screen | cut -d 'x' -f 1)                       # X Position
    screenY=$(echo $screen | cut -d 'x' -f 2 | cut -d '+' -f 1)     # Y Position
    deltaX=$(echo $screen | cut -d '+' -f 2)      # X Offset
    deltaY=$(echo $screen | cut -d '+' -f 3)      # Y Offset

    echo "$screenX $screenY $deltaX $deltaY"

    xPos=$(($deltaX + $screenX/2 - $resX/2))
    yPos=$(($deltaY + $screenY/2 - $resY/2))

    # Add the icon to the screen
    convert /tmp/screen.png $HOME/.config/i3/lock.png -geometry +$xPos+$yPos -composite -matte /tmp/screen.png
done

# Lock that sucka
i3lock -e -n -i /tmp/screen.png
