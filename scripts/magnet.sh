#!/bin/bash


# Advanced programming
if [ $1 ]; then
	transmission-remote hog -n adam:torrents -a "$1";
fi
