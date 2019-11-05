#!/bin/bash

for file in *.conf; do
    ln -s "`pwd`/$file" ~/.weechat/$file
done;
