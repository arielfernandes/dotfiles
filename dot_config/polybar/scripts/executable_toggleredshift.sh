#!/bin/bash
result=$(ps -C redshift | grep -o redshift)
if [ "$result" == "redshift" ]
then
redshift -x && killall redshift && notify-send "Screen Temperature Reset." -t 2000 
else
redshift -l $(curl -s "https://location.services.mozilla.com/v1/geolocate?key=geoclue" | jq -r '"\(.location.lat):\(.location.lng)"') &
notify-send "Screen Warmth Auto-Adjusting." -t 2000
fi
