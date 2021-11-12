#!/bin/bash

FILE=thermal.log
MAX_SIZE=5

if [ -f "$FILE" ]; then
    echo "INFO: $FILE exists."
    SIZE=$(du -k $FILE  | awk '{ print $1 }')
    if (($SIZE >= $MAX_SIZE)) ; then 
        echo "WARN: $FILE is more than 500 MBs! Truncating file..."
        rm $FILE
        echo "CPU,GPU,datetime" >> $FILE

    fi
else 
    echo "INFO: $FILE does not exist. Adding header..."
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
    logger -p daemon.info -t ThermalLog "$cpu,$gpu,$DATE" 
    echo "$cpu,$gpu,$DATE" >> $FILE
	sleep 0.05

    if [ -f "$FILE" ]; then
        SIZE=$(du -k $FILE  | awk '{ print $1 }')
        if (($SIZE >= $MAX_SIZE)) ; then 
            echo "WARN: $FILE is more than 500 MBs! Truncating file..."
            rm $FILE
            echo "CPU,GPU,datetime" >> $FILE
        fi
    else 
        echo "INFO: $FILE does not exist. Adding header..."
        echo "CPU,GPU,datetime" >> $FILE
    fi
done



#echo "CPU $cpu°C"
#echo "GPU $gpu°C"



