#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run with sudo."
  exit 1
fi

#checks if user is sudo

netname=$(nmcli -t -f name con show --active | head -n 1)

echo "
Network name: $(nmcli -t -f name con show --active | head -n 1)
IP Address: $(hostname -I)
Mac Address: $(ip link show wlan0 | awk '{print $2}' | tail -n 1)" 

#prints info

ip=$(ip addr show | grep inet | awk '{print $2}' | tail -n 2 | head -n 1)
mask=$(ip addr show | grep inet | awk '{print $2}' | tail -n 2 | head -n 1 | cut -d'/' -f2)

#isolates the ip with the subnet mask and just the subnet mask for later

v1=$(ip addr show | grep inet | awk '{print $2}' | tail -n 2 | head -n 1)
v2=$(hostname -I | cut -d'.' -f1-3)
v3=$(nmap -sn "$v1" | grep "Nmap scan report for" | awk '{print $5}')
 for i in {1..255}; do
     v4="$v2.$i"
 
     if ! echo "$v3" | grep -q "^$v4$"; then
         echo $v4
     fi
done | column 

echo "Please choose any ip listed above.
"
read newip
echo 
#enter in ip

nmap $newip | grep "Host is up"

if [ $? -eq 0 ]; then
    echo "IP in use please choose a different one."
    exit 1
fi

#makes sure ip entered isn't being used

newip2="$newip/$mask"
gateway="$(ip route | grep default | awk '{print $3}')"

#combines new ip with the subnet mask for first nmcli command

nmcli con mod $netname ipv4.addresses $newip2
nmcli con mod $netname ipv4.gateway $gateway
nmcli con mod $netname ipv4.dns $gateway
nmcli con mod $netname ipv4.method manual
nmcli con down $netname && nmcli con up $netname

#changing ip

echo "Do you want a new MAC? y/n"
read answer

if [ $answer == "y" ]; then
    echo "Please type your desired mac address. Needs to be 12 hexadecimal characters written as 6 pairs seperated by colons."
    read newmac
    sudo ifconfig wlan0 down
    sudo ip link set dev wlan0 address $newmac
    sudo ifconfig wlan0 up
    echo "Your new mac is $newmac"
    exit 1


elif [ $answer == "n" ]; then
    echo "Your new ip is $newip"
    exit 1
else
    echo "Invalid response."
    exit 1
fi


