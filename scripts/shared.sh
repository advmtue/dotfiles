#!/bin/bash

usage() {
    printf "Usage: $0 [-r|-u]\n\n\t-r\tConnect remotely\n\t-u\tUnmount\n"
    exit 1
}

# Default Action = Mount Local
DESTINATION="hog"
UNMOUNT=0

# Determine if hog is accessible
while getopts ":ru" o; do
    case "${o}" in
        r)
            DESTINATION="hogvpn"
            ;;
        u)
            UNMOUNT=1
            ;;
        *)
            usage
            ;;
    esac
done

# Action = Unmount
if [ $UNMOUNT -eq 1 ]; then
    # Unmount the directory
    umount $HOME/shared
    # Exit
    exit $?
fi

# Action = Mount
echo "Mounting server '$DESTINATION' -> $HOME/shared"
sshfs -o users,idmap=user ${DESTINATION}: $HOME/shared
exit $?
