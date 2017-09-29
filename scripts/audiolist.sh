#!/bin/bash

# Audio device namer
# Translates an audio device from its name to a nicer one

declare -A output_list
output_list["hdmi-output-1"]="SCREEN"
output_list["analog-output-lineout"]="SPEAKER"
output_list["analog-output-headphones"]="HEADPHONE"
output_list["none"]="NONE"
output_list["unknown"]="UNKNOWN"

device_name="unknown"

while read output_type; do
  if [ -n "${output_list[$output_type]}" ]; then
    device_name=$output_type
  fi
done

echo ${output_list[$device_name]}
