#!/bin/bash
# Check arg variable
if [ $1 ]; then
    # If argv conatains slash this mean we want open present dir
    if [[ $1 == */* ]]; then
	path=$1
    else
	path=`find ~/develop -maxdepth 3 -iname $1 -type d|tail -n 1`
    fi
else
    path=$HOME
fi
emacs --title EmacsDev --chdir $path &>/dev/null &
