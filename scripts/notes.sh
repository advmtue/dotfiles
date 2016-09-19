#!/bin/bash

# Notes.sh
#   Rsync-based note saving

# Usage
#   notes save                  # Save notes to server
#   notes get                   # Pull notes from server
#   notes new (name)            # Create new note with (name) and nvim
#   notes delete (name)         # Delete a note with given name
#   notes list                  # List all notes

# Important:
#   notes delete moves note to .bin folder


##################################################
#   Setup

# If .notes directory doesn't exist create it
if [[ ! -d $HOME/.notes ]]; then
    mkdir $HOME/.notes
fi

# If .notes/bin directory doesn't exist create it
if [[ ! -d $HOME/.notes/.bin ]]; then
    mkdir $HOME/.notes/.bin
fi

##################################################
#   Functions

saveNotes () {
    rsync -rave "ssh adam" --delete-before "$HOME/.notes/" :~/.notes/
}

getNotes() {
    rsync -rave "ssh adam" --delete-before :~/.notes/ "$HOME/.notes/"
}

listNotes() {
    ls "$HOME/.notes"
}

deleteNote () {
    echo "Deleted note: $1"
    mv "$HOME/.notes/$1" "$HOME/.notes/.bin/$1"
}

newNote () {
    if [[ "$1" && ! -e "$HOME/.notes/$1" ]]; then
        nvim $HOME/.notes/"$1"
    fi
}

badUsage () {
    echo "Error: Bad usage."
    echo "Try:"
    echo "  notes save"
    echo "  notes get"
    echo "  notes list"
    echo "  notes delete (name)"
    echo "  notes new (name)"
}

##################################################
#   Execute

if [[ $1 && "$1" == "save" ]]; then
    saveNotes
elif [[ $1 && "$1" == "get" ]]; then
    printf "Getting notes will delete all local changes!\n"
    printf "Continue?[y/N]: "
    read -n 1 selection
    if [[ "$selection" == "y" ]]; then
        getNotes
    else
        echo "Abort."
    fi
elif [[ $1 && "$1" == "list" ]]; then
    listNotes
elif [[ $1 && "$1" == "delete" ]]; then
    if [[ "$2" && -e "$HOME/.notes/$2" ]]; then
        deleteNote "$2"
    else
        echo "Error: deleteNote bad argument"
        echo "  Note does not exist"
    fi
elif [[ $1 && "$1" == "new" ]]; then
    if [[ $2 && ! -e "$HOME/.notes/$2" ]]; then
        newNote "$2"
    else
        echo "Error: newNote bad argument"
        echo "  Note '$2' already exists"
    fi
else
    badUsage
fi
