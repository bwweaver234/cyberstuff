#!/bin/bash

used=$(df / | awk '{print $5}' | tail -1 | tr -d '%')
#defining the variable used as the percentage of space used without the percentage sign

echo "Disk usage"
df -h /
# shows the info in gb and the amount of space used

if [ "$used" -le 69 ]; then
    message="You're good, you have only used up $used% of your space."
elif [ "$used" -le 89 ]; then
    message="Keep an eye out, you've used up $used% of your space."
elif [ "$used" -le 98 ]; then
    message="Please get a new disk. Home is $used% full"
elif [ "$used" -le 99 ]; then
    message="I'm drowning over here! Home is at $used% full!"
else
    message="It's too late for me... $used%"
fi
#if the used number is less than or equal to whatever number, then it shows the message

echo "$message"
