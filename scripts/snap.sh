#!/bin/bash

#   Take a screenshot of the desktop and save it to a temp file

lastpic="$(mktemp -u).png"
scrot $lastpic
