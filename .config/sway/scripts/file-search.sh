#!/bin/bash
# Search files in home directory
# First dialog chooses which directory in home to explore
# Second dialog chooses the file

DIRECTORY=`fd --type d --max-depth 1 --base-directory $HOME | wofi --dmenu`

if [ -n "$DIRECTORY" ]
then
    fd --type f --base-directory $HOME/$DIRECTORY | wofi --dmenu | xargs -I{} xdg-open $HOME/$DIRECTORY/{}
fi
