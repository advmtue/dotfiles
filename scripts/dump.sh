#!/bin/bash

#   Mount/Unmount the dump

if [ "$#" -ne 1 ]; then
    echo "Illegal number of arguments"
    exit 0
fi

mounted=`mount | grep /mnt/dump > /dev/null`

case $1 in
    "mount")
        if mount | grep /mnt/dump > /dev/null; then
            echo "/mnt/dump is already mounted"
            exit 0
        fi
        sshfs dump:/home/dump/src/dumpster/public /mnt/dump
        ;;
    "unmount")
        if mount | grep /mnt/dump > /dev/null; then
            fusermount -u /mnt/dump
            exit 0
        fi
        echo "/mnt/dump is not mounted"
        ;;
esac
