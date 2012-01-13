#!/bin/sh

IMPORTANT_ADDRESS="192.168.1.3 192.168.1.4"

function ping_command(){
    ping -c 2 -w 2 "$1" -q &>/dev/null
}


function check_live_hosts {
    for i in $IMPORTANT_ADDRESS; do 
        if ping_command $i ; then
            return 0
        fi
    done
    return 1
}

function check_ssh {
    if [ -n "$(ps aux|grep ssh|grep sshd:|grep -v grep)" ]; then return 0; fi
    return 1
}

function main {
    # If of each is true we stopped rtorrent. Else we start it )
    if check_live_hosts || check_ssh ; then
	sudo /etc/init.d/transmission-daemon start
	sleep 10
	transmission-remote -u 0 -d 0
	echo "Start and limited torrent $(date)"
    else
	transmission-remote -U -D
	sudo /etc/init.d/transmission-daemon stop
	sleep 10
	echo "Stop and unlimite torrent $(date)"
    fi
}

main
