#!/bin/bash

# m4amp3 Conver m4a to mp3 with faad2 and lame

if ! [[ -d '_wav' ]]; then
    mkdir '_wav'
fi

if ! [[ -d '_mp3' ]]; then
    mkdir '_mp3'
fi

if ! [[ -d '_m4a' ]]; then
    mkdir '_m4a'
fi

for file in *.m4a; do
    baseName=${file::-4}
    faad "$file" -o "_wav/$baseName.wav"
    lame "_wav/$baseName.wav" "_mp3/$baseName.mp3"
    mv "$file" "_m4a/$file"
done
