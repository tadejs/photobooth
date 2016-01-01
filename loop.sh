#!/bin/bash
while :
do
	sleep 1
	zenity --question --text="Take picture?" && ./shoot.sh || exit 0
done
 
