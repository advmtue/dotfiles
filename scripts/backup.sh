#!/bin/bash

# Backup script for backing things up
#
# Usage:
#   backup source dest

#   Global Variables
##################################################
SOURCE=$()
DEST=$()
SNAPSHOT_NAME="snap.shot"
FILE_PREFIX="backup_"
FILE_SUFFIX=".tar.gz"

#   Functions
##################################################
# function: getNextBackupName
#   Gets the next available backup file name
#   Assumes that all backup files are appropriately named
getNextBackupName () {
    count=0
    while true; do
        potential=`ls $DEST | grep $FILE_PREFIX$count$FILE_SUFFIX`
        if [[ -z "$potential" ]]; then
            break
        fi
        let count=$count+1
    done
    echo "$FILE_PREFIX$count$FILE_SUFFIX"
}

# Execute
##################################################
if [[ "$1" && -d "$1" ]]; then
    SOURCE="$1"
    if [[ "$2" && -d "$2" ]]; then
        DEST="$2"
        nextName=$(getNextBackupName)
        echo "BACKUP INFORMATION:"
        echo "  SOURCE DIR: $SOURCE"
        echo "  BACKUP DIR: $DEST"
        echo "  BACKUP NAME: $nextName"
        echo "  SNAPSHOT: $DEST/$SNAPSHOT_NAME"
        printf "\nProceed with backup?[y/N]: "
        read -n 1 selection
        if [[ "$selection" == "y" ]]; then
            tar -cvzf "$DEST/$nextName" -C "$SOURCE" -g "$DEST/$SNAPSHOT_NAME" .
        else
            printf "\nBackup aborted, no changes have been made\n"
        fi
    fi
else
    echo "Incorrect usage:"
    echo "  Try: backup (source) (dest)"
fi
