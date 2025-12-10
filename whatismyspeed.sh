#!/bin/bash

echo "Testing speed... (Might take a minute.)"

server=$(echo "$(speedtest-cli)" | grep "Testing from")
downloadspeed=$(echo "$(speedtest-cli)" | grep "Download:" | awk '{print $2, $3}')
upload=$(echo "$(speedtest-cli)" | grep "Upload:" | awk '{print $2, $3}')
#isolating the info

echo "
$server
$downloadspeed
$upload"
#echoing info to terminal

echo "$(date)" >> speedtestlog.txt
echo "$server" >> speedtestlog.txt
echo "Download speed: $downloadspeed" >> speedtestlog.txt
echo "Upload speed: $upload" >> speedtestlog.txt
echo "___________________________________________" >> speedtestlog.txt
#saving date and info to log and adding a line because its hard to read without it

download=$(echo "$(speedtest-cli)" | grep "Download:" | awk '{print $2}' | tr -d '.')
#removes the . because bash doesn't usually work with decimals

if [ "$download" -lt 400 ]; then
    #since the decimal was taken out, 40.0 mbps is now 400
    echo "Your speed is terrible! Yell at your ISP right now!"
else
    echo "Your speed is alright."
fi
