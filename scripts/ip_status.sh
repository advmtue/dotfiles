#!/bin/bash

STATUS_FILE='/tmp/ip_status.log'
STATUS_LAST='- no ip -:0:0'
MAX_ATTEMPTS=3

# Requires three inputs
# $1 = ip address
# $2 = status_type
# $3 = status_attempts
#
# status_type
# 0 = Good (pulled on latest refresh)
# 1 = Stale (stale request)
# 2 = Bad (network is down) [hit max attempts]

# Get the last status if it exists
if [ -f $STATUS_FILE ]; then
	STATUS_LAST="$(cat $STATUS_FILE)"
fi

# Split last status into variables
IP=`echo $STATUS_LAST | cut -d ":" -f 1`
TYPE=`echo $STATUS_LAST | cut -d ":" -f 2`
ATTEMPTS=`echo $STATUS_LAST | cut -d ":" -f 3`

# Try to get the current WAN IP
NEW_IP=`curl -s --max-time 1 ip.adamtue.ch`

# If the pull...
if [ -z $NEW_IP ]; then
	# ... fails, set ip to unknown, stale request, and increment attempts
	ATTEMPTS=`expr $ATTEMPTS + 1`
	TYPE=1
	# If we hit max failures, assume the link is dead
	if [ $ATTEMPTS -ge  $MAX_ATTEMPTS ]; then
		IP="- no ip -"
		TYPE=2
		ATTEMPTS=$MAX_ATTEMPTS
	fi
else
	# ... succeeds, set everything to good
	IP=$NEW_IP
	ATTEMPTS=0
	TYPE=0
fi

# Writeout
echo "$IP:$TYPE:$ATTEMPTS" > $STATUS_FILE

# If an arg is passed, return polybar status info
if [ -n $1 ]; then
	case $TYPE in
		0)
			echo "%{F#8c9440}%{F-}"
			;;
		1)
			echo "%{F#de935f}%{F-}"
			;;
		2)
			echo "%{F#a54242}%{F-}"
			;;
	esac
fi
