#!/bin/sh
# This is simple stop and start rtorrent script for crontab
# If one of IMPORTANT_ADDRESS is live, we stop rtorrent, else start

IMPORTANT_ADDRESS="192.168.1.3 192.168.1.4"

function ping_command(){
    ping -c 2 -w 2 "$1" -q &>/dev/null
}

function rtorrent_status {
    if [ "$(pidof rtorrent)" ]; then
        echo "up"
    else
        echo "down"
    fi
}

function rtorrent_start {
    if [ "$(rtorrent_status)" = "down" ]; then
        screen -d -m -S rtorrent rtorrent &> /dev/null
        echo "start rtorrent"
    else
        echo "rtorrent already started"
    fi
}

function rtorrent_stop {
    if [ "$(rtorrent_status)" = "down" ]; then
        echo "Rtorrent already down"
    else
        killall rtorrent
        sleep 10
        if [ "$(rtorrent_status)" = "up" ]; then killall -9 rtorrent; fi
    fi

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
        rtorrent_stop
    else
        rtorrent_start
    fi
}

main
