#!/bin/bash

#   todo.sh
#       Basic script for adding things I need to do

#   Ensure something is mounted at /mnt/vps
if [ `df | grep "/mnt/vps" | wc -l` == "0" ]; then
    printf "%s\n" "Error! VPS is not mounted."
    printf "%s\n" "-- Remember to mount it first with 'smount vps'"
    printf "%s\n" "Exiting..."
    exit 1
fi

#   Make the todo file if it doesn't exist
if [ ! -f "/mnt/vps/.todo" ]; then
    printf "%s" "Creating /mnt/vps/.todo file..."
    touch "/mnt/vps/.todo"
    printf "%s\n" "Done!"
fi

#   Now we can start doing things
#   Options
#   todo
#       -> default = list
#   todo add
#   todo remove


#   Print the list with numbers
function todo_list {
    printf "\n--- LIST\n"
    counter=1
    while read p; do
        printf "%d. %s\n" $counter "$p"
        ((counter++))
    done </mnt/vps/.todo

    printf "\n"
}

#   Add a todo
function todo_add {
    read -p "New TODO: " new_todo
    echo "$new_todo" >> /mnt/vps/.todo
}

#   Remove a todo
function todo_remove {
    todo_list
    read -p "Number to remove: " remove_todo

    if [[ -n ${remove_todo//[0-9]/} ]]; then
        printf "%s\n" "Error! Non-numeric input"
        printf "%s\n" "Exiting..."
        exit 1
    fi

    printf "Removing todo #%s... " "$remove_todo"

    new_file=$(sed -e "${remove_todo}d" /mnt/vps/.todo)
    echo "$new_file" > /mnt/vps/.todo

    printf "%s\n" "Done!"
}

#   Print Usage
function todo_usage {
    printf "%s\n" "--- TODO -----------"
    printf "  %s\n" "todo list"
    printf "  %s\n" ".... add"
    printf "  %s\n" ".... remove"
    printf "  %s\n" ".... help"
}


#   Run
case "$1" in
    "list")
        todo_list
        ;;
    "add")
        todo_add
        ;;
    "remove")
        todo_remove
        ;;
    "help")
        todo_usage
        ;;
    *)
        todo_list
        ;;
esac
