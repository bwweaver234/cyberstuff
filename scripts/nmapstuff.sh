#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run with sudo."
    exit 1
fi

#Checks if user is sudo user

echo "IP: $(hostname -I)"

echo "Netmask: $(ifconfig wlan0 | grep "inet" | awk '{print $4}' | head -n 1)"

#echoes ip and netmask

if [ $# == 0 ]; then
    echo "Please enter the range and ip address."
fi

#if there are no arguments tell user to enter range and ip

scan=$(sudo nmap -sn $1)

#I stored this in a variable so it would only run nmap once otherwise it would do it three times for the
#ip, mac, and name

ip=$(echo "$scan"  | awk '{print $5}' | tr -d "Cabcdefghijklmnopqrstuvwxyz//:)(" | grep -v '^$' | grep -vE '^.$')
mac=$(echo "$scan"| awk '{print $3}' | tr -d "abcdefghijklmnopqrstuvwxyz." | sed '1d;$d' | grep -v '^$')
name=$(echo "$scan" | grep "(" | awk '{print $4, $5}' | grep -v "latency" | sed '1d;$d')

#pull all the info from the nmap scan

echo "IP              MAC                      NAME"
paste <(echo "$ip") <(echo "$mac") <(echo "$name")

#put all the info in columns next to each other
