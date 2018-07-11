#!/bin/bash

#   smount.sh
#       (Un)Mount predefined filesystems using ssh
#
#   Usage:
#       smount NAME [unmount]

#   My filesystems
#       Add more by editing the get_mount_cmd function
#   bin     = bin.adamtue.ch        -> /mnt/bin
#   moose   = 10.1.1.65             -> /mnt/moose
#   vps     = adamtue.ch [private]  -> /mnt/vps
#   deakin  = interactive.deakin... -> /mnt/deakin

#   Script assumes these directories already exist
#   TODO: Create and delete directories as needed

OSVERSION=`uname`
USER=`whoami`

#   Construct a large line seperator because printf doesn't loop
LINE_SEP="="
LINE_SEP_LEN=7
while [ $LINE_SEP_LEN -gt 0 ]; do
    LINE_SEP="$LINE_SEP$LINE_SEP"
    LINE_SEP_LEN=`expr $LINE_SEP_LEN - 1`
done

#   @func get_mount_point
#   @desc Get the local mount point of a remote location
#   @param $1 Name of remote location (eg. "moose")
#   @returns Location (local mount point)
function get_mount_point {
    case "$1" in
        "bin")
            echo "/mnt/bin"
            ;;
        "moose")
            echo "/mnt/moose"
            ;;
        "vps")
            echo "/mnt/vps"
            ;;
        "deakin")
            echo "/mnt/deakin"
            ;;
        *)
            echo "ERROR"
    esac
}

#   @func get_mount_cmd
#   @desc Returns the command used to mount a particular location
#   @param $1 Name of remote location (eg. "moose")
#   @returns CMD to mount location
function get_mount_cmd {
    case "$1" in
        "bin")
            echo "bin:src/dumpster/public/ /mnt/bin"
            ;;
        "moose")
            echo "moose:/ /mnt/moose"
            ;;
        "vps")
            echo "adam:private /mnt/vps"
            ;;
        "deakin")
            echo "deakin: /mnt/deakin"
            ;;
        *)
            echo "ERROR"
    esac
}

#   Check if the action is to unmount
if [ -n "$2" ]; then
    MOUNTPOINT=`get_mount_point $1`
    if [ "$MOUNTPOINT" == "ERROR" ]; then
        echo "Unknown mount point, try something else bud"
        exit 1
    fi

    #   OSX doesn't have fusermount for some reason
    CMD="fusermount -u $MOUNTPOINT"
    if [ "$OSVERSION" == "Darwin" ]; then
        echo "Using custom -OSX- unmount script"
        CMD="sudo umount $MOUNTPOINT"
    fi
    echo "Executing: $CMD"
    `$CMD`
    echo "Done!"
    exit 0
fi

#   Check that the mount cmd doesn't error out
MOUNTPOINT=`get_mount_cmd $1`
if [ "$MOUNTPOINT" == "ERROR" ]; then
    echo "Unknown hostname, try something else lmao"
    exit 1
fi

#   OSX is rude, do special things for it
SSHFS_CMD="sshfs"
if [ "$OSVERSION" == "Darwin" ]; then
    printf "\n%s\n" "-OSX Detected- Using custom mount options"
    SSHFS_CMD="sudo sshfs -o defer_permissions,allow_other -F /Users/$USER/.ssh/config"
fi

#   The CMD that will be executed
FULL_CMD="$SSHFS_CMD $MOUNTPOINT"

#   Print information about what's about to run
printf "%.*s\n" ${#FULL_CMD} "$LINE_SEP"
printf "%s\n%s\n" "Using the following connect string:" "$FULL_CMD"
printf "%.*s\n" ${#FULL_CMD} "$LINE_SEP"
printf "\n%s\n\n" "Executing..."

#   Execute the CMD
#       After this, the application will ask for ssh information via the regular provider
`$FULL_CMD`
