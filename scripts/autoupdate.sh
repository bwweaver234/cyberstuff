#!/bin/bash

echo "Welcome $USER"

echo "Beginning auto update script at $(date)"
apt update
apt upgrade -y
apt autoremove -y

echo "Update complete at $(date)"

while true; do
    echo "Do you want to reboot, shutdown, or exit the script? r/s/e"

    read answer
    if [ $answer == "r" ] ; then
        echo "Starting reboot now."
        reboot now
        break
    elif [ $answer == "s" ] ; then
        echo "Shutting down."
        shutdown now
        break
    elif [ $answer == "e" ] ; then
        echo "Exiting script"
        exit 1
        break
    else echo "Invalid response."
    fi
done
