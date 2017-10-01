#!/bin/bash

# Audio device namer
# Translates an audio device from its name to a nicer one

declare -A output_list
output_list["hdmi-output-1"]=""
output_list["analog-output-lineout"]=""
output_list["analog-output-headphones"]=""
output_list["none"]=""
output_list["unknown"]=""

device_name="unknown"

while read output_type; do
  if [ -n "${output_list[$output_type]}" ]; then
    device_name=$output_type
  fi
done

echo ${output_list[$device_name]}
