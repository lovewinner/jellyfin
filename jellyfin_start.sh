#!/bin/bash
myFile="/dev/dri/renderD128"
 if [ ! -f "$myFile" ]; then
 chmod 777 "$myFile"
 fi

 /usr/bin/jellyfin