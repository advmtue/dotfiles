#!/usr/bin/python
# Weather - Simple weather data

import json;
import requests;
import sys;


# Fahrenheit to Celcius conversion
def f_to_c(f):
    return (5*(f-32))/9

# LAT/LONG for Geelong Australia
LAT = '-38.1499'
LONG = '144.3617'
KEY = 'SomeAPIKeyWouldGoHereButImNotSillyEnoughToPutItInAGitRepo'

# Get the forecast API key
f = open('/home/aclaivi/.config/lemonbar/.secret_weatherapi', 'r')
KEY = f.read().split('\n')[0]
f.close()

# URL
API_URL = 'https://api.forecast.io/forecast/'+KEY+'/'+LAT+','+LONG

# Make the request
r = requests.get(API_URL)

# Chekkit
if (r.status_code == 200):
    current = r.json()['currently']
    temp = round(f_to_c(current['temperature']), 1)
    sys.stdout.write(str(temp))
