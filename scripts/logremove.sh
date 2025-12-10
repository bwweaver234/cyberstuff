#!/bin/bash

if [ "$#" -eq 0 ]; then
    echo "Please enter a list of files or directories you want to delete" >&2
    # >&2 redirects into the stderr
    exit
fi
#If there is nothing typed after the command then it tells you to please enter what you want to delete

silent=false
if [ "$1" == "-s" ]; then
    silent=true
    shift
fi
#if there is an argument, and it is -s, then silent mode is active

logfile="$HOME/Desktop/removed.log"

for file in "$@"; do
    if [ -e "$file" ]; then
        rm -rf "$file"
        #Remove the list of files and directories typed
        if [ "$silent" = false ]; then
            echo "$(date) - Removed $file" >> "$logfile"
            echo "Removed: $file"
            #So that silent mode doesn't record files deleted or tell you which file was deleted
         fi
    fi
done

