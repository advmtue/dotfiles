#!/bin/sh

for i in *.flac; do
  ffmpeg -i "$i" -qscale:a 0 "${i[@]/%flac/mp3}"
done
