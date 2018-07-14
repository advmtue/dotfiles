#!/bin/bash

xrdb -l /home/aclaivi/.Xresources
i3-msg "workspace 7; append_layout ~/.config/i3/w_music.json"

(urxvt -e ncmpcpp -h 10.1.1.65 &)
(urxvt -e pulsemixer &)
(urxvt -e bluetoothctl &)
