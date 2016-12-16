#!/bin/bash

# gainalbum.sh
#   Script to write replaygain tags of all mp3 files in a dir
#   Assumes that directory is one album

# Text for identification of modified files
echo "gainalbum.sh..."
echo "Files to be modified:"
for f in *.mp3; do
  printf "\t$f\n"
done

# Do some shit
printf "\nAnalyze and apply? [y/N]: "
read -n 1 selection
if [[ "$selection" == "y" ]]; then
  printf "\nAlright boss, doin' shit...\n"
  find . -name "*.mp3" -exec mp3gain -d 6 -k -r -s r {} \;
else
  printf "\nAborted.\n"
fi
