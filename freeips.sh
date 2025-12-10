#!/bin/bash

v1=$(ip addr show | grep inet | awk '{print $2}' | tail -n 2 | head -n 1)
v2=$(hostname -I | cut -d'.' -f1-3)
v3=$(nmap -sn "$v1" | grep "Nmap scan report for" | awk '{print $5}')
for i in {1..255}; do
    v4="$v2.$i"

    if ! echo "$v3" | grep -q "^$v4$"; then
        echo $v4
    fi
done | column
