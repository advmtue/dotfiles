#!/bin/bash

#   Mount/Unmount the dump

if [ "$#" -ne 1 ]; then
    echo "Illegal number of arguments"
    exit 0
fi

mounted=`mount | grep /mnt/dump > /dev/null`

case $1 in
    "mount")
        if $mounted; then
            echo "/mnt/dump is already mounted"
            exit 0
        fi
        sshfs adam:/home/adamtuechler/src/dumpster/public /mnt/dump
        ;;
    "unmount")
        if $mounted; then
            echo "/mnt/dump is not mounted"
        else
            fusermount -u /mnt/dump
        fi
        ;;
esac
