#!/bin/bash

#   Get WAN IP Address

#   Using DIG
#       Works quite well as dnscrypt-proxy caches
dig +short myip.opendns.com @resolver1.opendns.com

#   Using CURL
#curl -s http://whatismyip.akamai.com/
