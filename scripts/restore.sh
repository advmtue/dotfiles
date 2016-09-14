#!/bin/bash

# Restore files from backup scheme
#   Must be executed in directory where backups are saved
# Usage:
#   restore dest

# Global Variables
##################################################
DEST=$()

# Functions
##################################################

isBackupDir () {
    files=`ls $PWD | grep "backup_0.tar.gz"`
    if [[ "$files" ]]; then
        echo 1
    else
        echo 0
    fi
}

restoreBackups () {
    count=0
    while true; do
        file=`ls $PWD | grep "backup_$count.tar.gz"`
        if [[ "$file" ]]; then
            $(tar -xzf backup_$count.tar.gz -G -C $DEST)
            let count=$count+1
        else
            echo "No more backups to restore"
            break
        fi
    done
}

if [[ "$1" && -d "$1" ]]; then
    DEST="$1"
    if [[ $(isBackupDir) == 1 ]]; then
        echo "Restoring backup!"
        restoreBackups
    else
        echo "PWD doesn't contain backups"
    fi
fi
