#!/bin/bash

# Audio Refresh
# Move every sink-input to the @DEFAULT_SINK@

sink_input_list="$(pactl list short sink-inputs | awk '{print $1}')"

# Move those suckers
for sink_input in $sink_input_list; do
  pactl move-sink-input $sink_input @DEFAULT_SINK@
done

# And now we pray
