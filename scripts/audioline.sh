#!/bin/bash

# Audioline toggler
# Toggles between predefined audio sinks
# Also moves all sink-inputs to the new sink

# Notes:
#   When moving to the analog-out sink (usually sink 2)
#     the master volume will be set to 30 to stop ears from
#     exploding
#   When moving back to HDMI the volume will be set to
#     100%. So be warned :)


# Global variables
SINKNUM_HDMI=0
SINKNUM_ANALOG=2


# By default the new active sink will be HDMI
sink_new_active=$SINKNUM_HDMI
master_new_volume=100

# Get active sink
sink_active="$(pactl list short sinks | gawk '/RUNNING|IDLE/ {print $1}')"

# Determine which sink to switch to
if [ "$sink_active" == "$sink_new_active" ]; then
  sink_new_active=$SINKNUM_ANALOG
  master_new_volume=40
  pactl set-sink-port "$SINKNUM_ANALOG" analog-output-headphones
fi

# Set the new_active
pactl set-default-sink $sink_new_active

# Get a list of sink-inputs
sink_input_list="$(pactl list short sink-inputs | awk '{print $1}')"

# Move all sink inputs to the new defaut sink
for sink_input in $sink_input_list; do
  pactl move-sink-input $sink_input $sink_new_active
done

# Set the master volume
amixer -q sset Master "$master_new_volume"% unmute
