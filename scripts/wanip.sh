#!/bin/bash

#   Get WAN IP Address

#   Seems to be slow on VPN for some reason
#   dig +short myip.opendns.com @resolver1.opendns.com

#   Using CURL
curl -s http://whatismyip.akamai.com/
