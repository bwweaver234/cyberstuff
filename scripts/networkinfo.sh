#!/bin/bash
#
#
echo "User: $USER
Date: $(date)

Network Information:
Network name: $(nmcli -t -f name con show --active | head -n 1)
IP Address: $(hostname -I)
Mac Address: $(ip link show wlan0 | awk '{print $2}' | tail -n 1) 
Range: $(ifconfig wlan0 | awk '/netmask/{print $4}')
Gateway: $(ip route | grep default | awk '{print $3}')
Broadcast: $(ifconfig wlan0 | grep 'inet' | awk '{print $NF}' | head -n 1)"
