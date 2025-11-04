#!/bin/bash

#changed /bah to /bash

echo "Checking for updates..."

sudo apt-get update
#added dash

if [ $? -eq 0 ]; then
    # added spaces and semicolon and then put then after, changed -q to -eq 
    echo "System update complete"
    sudo apt list --upgradable | grep -v "Listing..."
    echo "You have $(sudo apt list --upgradable | wc -l ) packages that can be updated"
else
    echo "something went wrong"
    # changed all ' to "
fi

