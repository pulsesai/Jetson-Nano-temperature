#!/bin/bash

FILE=thermal.log
if [ -f "$FILE" ]; then
    echo "$FILE exists."
else 
    echo "$FILE does not exist. Adding header ..."
    echo "CPU,GPU,datetime" >> $FILE
fi

echo "Press [CTRL+C] to stop.."

while true
do
	CPU_temp=$(cat /sys/class/thermal/thermal_zone1/temp)
    GPU_temp=$(cat /sys/class/thermal/thermal_zone2/temp)
    cpu=$((CPU_temp/1000))
    gpu=$((GPU_temp/1000))
    DATE=$(date '+%Y-%m-%d %H:%M:%S')
    
    echo "$cpu,$gpu,$DATE" 
    echo "$cpu,$gpu,$DATE" >> $FILE
	sleep 30
done



#echo "CPU $cpu°C"
#echo "GPU $gpu°C"



