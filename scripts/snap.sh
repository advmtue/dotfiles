#!/bin/bash

#   Take a screenshot of the desktop and save it to a temp file

lastpic="$(mktemp -u).png"
if [ "$1" = "-a" ]; then
    scrot -s $lastpic
else
    scrot $lastpic
fi
