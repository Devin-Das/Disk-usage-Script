#!/bin/bash

printf "\n\n ----  Result for Disk Usage on /dev/sda3/   ----"
diskusage=$(df -h / | awk '{print $5}' | tr -d [:alpha:],[=%=] | sed '/^$/d')
if [[ $diskusage -ge 85 ]]; then
alert="Disk usage on  /dev/sda3 reached the limit! Usage at $diskusage%"
printf "\n\nDisk usage has reached limit. Sending alert notification ------"
echo ${alert} | mail -s "Disk Usage Alert" myemail@gmail.com
if [ ${?} -eq 0 ]; then
echo "Notification sent"
else
printf "\nSending notification failed. Check if your network and mail services are installed & configured properly\n\n"
exit 1
fi
fi

if [[ $diskusage -le 84 ]]; then
printf "\n\nDisk Usage within limit for /dev/sda3\n\nUsage is at ${diskusage}%%"

diskavail=$(df -h / | awk '{print $4}' | tr -d 'Avail' | sed '/^$/d')
printf "\n\nDisk available : ${diskavail}B"
disktotal=$(df -h / | awk '{print $2}' | tr -d 'Size' | sed '/^$/d')
printf "\n\nDisk total : ${disktotal}B\n\n"
printf "\n --- End of Result ---\n\n"
fi
