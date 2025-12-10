#/bin/bash

if [ $# == 0 ]; then
    echo "Usage: $0 <ip_address>"
fi

ip=$1

echo "Scanning $ip for open ports..."

nmap -sV -oG results.txt $ip

if [ ! -f "results.txt" ]; then
    echo "Scan file missing!!"
fi

openports=$(grep "Ports:" results.txt | cut -d ":" -f 3)

if [ "$openports" == "" ]; then
    echo "No open ports found"
else
    echo "Open Ports detected"
    echo $openports
fi
