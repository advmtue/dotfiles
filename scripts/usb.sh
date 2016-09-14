#!/bin/bash

# USB Mount/Unmount Tool
#
# Usage:
#   usb -m (disk)           == Mounts /dev/sd(disk)
#   usb -u (num)            == Unmounts /mnt/usb(num)
#   usb -l                  == Lists active usb mounts

ARG1="$1"
ARG2="$2"

if [[ -z "$ARG1" ]]; then
    ARG1="-l"
fi

#   Root Check
##################################################
# Ensure that the script is only being run as root
#   Allows running of the -l command as regular user
if [[ $EUID -ne 0 ]]; then
    if [ "$ARG1" != "-l" ]; then
        echo "This script can only be run as root..."
        exit 1
    fi
fi

#   Global Variables
##################################################
dstart="d"
usbPrefix="/mnt/usb"
usbCount=4

#   Functions
##################################################
# Function: getFreeMounts()
#   Find the next available usb mount point
#   Returns:
#       /mnt/usb(1-4) if mount point available
#       null if not mount points available
getFreeMounts() {
    counter=1
    while [ $counter -lt $usbCount ]
    do
        if [[ "$(cat /proc/mounts | grep /mnt/usb$counter)" ]]
        then
            let counter=$counter+1
            continue
        else
            echo "$usbPrefix$counter"
            break
        fi
    done
}

# Function: validDisk()
#   Check if a supplied disk is valid
#       Valid: returns $1
#       Invalid: returns null
validDisk() {
    # Diskpart is the disk and partition /dev/sd(d1)
    diskpart=$(echo "$1" | grep -oP "(?<=sd)([b-z][1-9])")
    # Disk is null if disk is restricted or invalid
    disk=$(echo "$diskpart" | grep -m 1 -oP "([$dstart-z])")

    if [[ "$disk" ]]; then
        echo "$1"
    fi
}

# Function: badUsage()
#   Print out the corrent usage
badUsage() {
    echo "Error:    Bad usage"
    echo "Try:      usb -(m|u) (DiskPart|([1-4]))"
    exit 0
}

#   Execution
##################################################
if [[ "$ARG1" && "$ARG1" == "-m" ]];
then
    if [[ "$ARG2" ]]; then
        disk="$(validDisk $ARG2)"

        # If disk is valid & not restricted
        if [[ "$disk" ]]; then

            # Check it's connected
            if [[ $(lsblk | grep $disk) ]]; then

                # Check it isn't already mounted
                activemounts=$(cat /proc/mounts | grep dev/$disk)
                if [[ -z $activemounts ]]; then

                    # Find a mountpoint for it
                    mountpoint=$(getFreeMounts)
                    if [[ "$mountpoint" ]]; then

                        # Mount that sucka
                        mount -o gid=users,fmask=113,dmask=002 "/dev/$disk"\
                            "$mountpoint"
                        echo "Mounted /dev/$disk @ $mountpoint"
                    else
                        echo "No available mount points"
                        echo "  Free up mount points and try again"
                        echo "  Test /mnt/usb([1-$usbCount])"
                    fi
                else
                    activemount="$(cat /proc/mounts | grep /dev/$disk)"
                    activemount="$(echo $activemount | cut -d ' ' -f 2)"
                    echo "Disk already mounted @ $activemount"
                fi
            else
                echo "Disk isn't connected"
            fi
        else
            echo "Invalid or restricted disk entered ($ARG2)"
            echo "  Diskstart is set to disk $dstart"
        fi
    else
        $(badUsage)
    fi
elif [[ "$ARG1" && "$ARG1" == "-u" ]]; then
    if [[ "$ARG2" ]]; then

        # if num within 1-4
        if [[ $ARG2 -gt 0 && $ARG2 -lt 5 ]]; then
            activemounts="$(cat /proc/mounts | grep /mnt/usb$ARG2)"

            # Check something is actually mounted
            if [[ "$activemounts" ]]; then
                echo "Unmounting /mnt/usb$ARG2..."
                umount /mnt/usb$ARG2
                echo "Unmounted."
            else
                echo "Nothing is mounted on /mnt/usb$ARG2"
            fi
        else
            echo "Invalid dir entered"
            echo "  Use usb -u [1-4]"
        fi
    else
        $(badUsage)
    fi
elif [[ "$ARG1" && "$ARG1" == "-l" ]]; then
    mounted=()
    unmounted=()
    while read line; do
        disk=`echo $line | grep -oP "(sd[$dstart-z][1-9])"`
        size=`echo $line | grep -oP "([0-9]*\.[0-9]*[A-Z])"`
        mountpoint=`echo $line | grep -oP "mnt/usb([1-$usbCount])"`
        if [[ "$mountpoint" ]]; then
            mounted+=("$disk ($size) @ $mountpoint")
        else
            unmounted+=("$disk ($size)")
        fi
    done < <(lsblk -no NAME,SIZE,MOUNTPOINT | grep -P "sd[$dstart-z][1-9]")

    echo "Mounted USB disks:"
    for ix in ${!mounted[*]}; do
        printf "\t%s\n" "${mounted[$ix]}"
    done

    printf "\nUnmounted USB disks:\n"
    for ix in ${!unmounted[*]}; do
        printf "\t%s\n" "${unmounted[$ix]}"
    done
else
    $(badUsage)
fi
