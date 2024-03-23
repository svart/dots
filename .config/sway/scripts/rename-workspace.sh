#!/bin/bash

WOFI=$HOME/.config/sway/scripts/exclusive-wofi.sh

predefined_names=(
    alacritty
    emacs
    firefox
    book
    telegram
    todoist
)

new_name=`
    for name in ${predefined_names[@]}
        do echo $name
    done | $WOFI --dmenu --prompt=workspace
`

if [ -z $new_name ]
then
    exit 0
fi

# Check if the provided name is in the list of programs
case $new_name in
    alacritty)
        new_name=""
        ;;
    emacs)
        new_name=""
        ;;
    firefox)
        new_name=""
        ;;
    book)
        new_name=""
        ;;
    telegram)
        new_name=""
        ;;
    todoist)
        new_name="✅"
        ;;
esac

# Get the current workspace number
workspace_number=$(swaymsg -t get_workspaces | jq '.[] | select(.focused == true).num')

# Set the new name for the workspace
new_name="${workspace_number}:${workspace_number}:${new_name}"

# Rename the workspace
swaymsg rename workspace to "${new_name}"
