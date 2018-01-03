#!/bin/bash

# This is a fucking stupid script that stops the mouse being
#   a turd accel-boy. Realistically this should be done in
#   configuration options :thinking:

id=$(xinput | grep -m 1 "SteelSeries" | gawk 'match($0, /([0-9])/, a) { print a[0] }')
xinput set-prop $id "libinput Accel Profile Enabled" [0, 1]

