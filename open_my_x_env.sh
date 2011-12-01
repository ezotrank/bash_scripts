#!/bin/bash

function open_work_screen(){
    urxvtc -name "Work" +sb -e screen -R work -c ~/.screenrc_1
}

MY_PROGRAMM="dropbox pidgin skype evolution odeskteam-qt4"
for programm in $MY_PROGRAMM; do
    if [ -n "$(ps aux|grep $programm|grep -v grep)" ]; then
        echo "$programm already started"
    else
        $programm &>/dev/null & 
    fi
done
open_work_screen
