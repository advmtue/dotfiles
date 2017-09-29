#!/bin/bash

# Audio source checker
# Outputs simple text naming the audio source


# Declare the names of the output list
declare -A output_list
output_list["hdmi-output-1"]="HDMI"
output_list["analog-output-lineout"]="SPEAKER"
output_list["analog-output-headphones"]="HEADPHONE"
output_list["none"]="UNKNOWN"
select_sink=0
output_device="none"
IFS='
'

# Check if the audio device is muted
# TODO

# Find the active sink (either RUNNING or IDLE)
ACTIVE_SINK=$(pactl list short sinks | gawk '/RUNNING|IDLE/ {print $1}')

# Get the active port
all_sinks=$(pactl list sinks | gawk '/Sink|Active Port/')

for line in $all_sinks; do
  # Check if the line is a sink number or an active port
  is_sink=$(echo $line | grep "Sink")

  if [ "$is_sink" != "" ]; then
    # If it's a sink, extract the number
    select_sink=$(echo $line | gawk 'match($0, /([0-9])/, a) {print a[0]}')
  else
    # If it's the port and check if the sink is the active one
    if [ $select_sink == $ACTIVE_SINK ]; then
      # If so, get the output port on the sink
      output_device=$(echo $line | awk '{print $3}')
    fi
  fi
done

# Output a translated version to make it nice
echo ${output_list["$output_device"]}
