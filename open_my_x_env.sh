#!/bin/bash

MY_PROGRAMM="dropbox pidgin skype evolution"
for programm in $MY_PROGRAMM; do
    if [ -n "$(ps aux|grep $programm|grep -v grep)" ]; then
        echo "$programm already started"
    else
        $programm &>/dev/null & 
    fi
done
