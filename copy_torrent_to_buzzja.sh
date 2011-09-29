#!/bin/bash

LOCAL_IP="192.168.1.3 192.168.1.4"
LOCAL_DEST="192.168.1.2:~/torrents"
REMOTE_DEST="buzzja.mine.nu:~/torrents"
LOCAL_TORRENT_SOURCE="$HOME/Downloads/"

# Return a string with all ips accept localhost ip
function show_ips {
    echo "$(/sbin/ifconfig | grep "inet addr" | cut -d: -f2 | cut -d' ' -f1|grep -v '127.0.0.1')"
}

# What network I use
function which_net {
    for l_ip in $LOCAL_IP; do
        for r_ip in `show_ips`; do 
            if [ $l_ip == $r_ip ]; then
                echo "home"
                exit 0
            fi
        done
    done
    echo "external"
}

# Simple copy torrent file to destination. If all good we delete local torrent files
function copy_torrent {
    scp $LOCAL_TORRENT_SOURCE/*.torrent $1 && rm $LOCAL_TORRENT_SOURCE/*.torrent
}

function main {
    if [ "$(which_net)" == "home" ]; then
        copy_torrent $LOCAL_DEST
    else
        copy_torrent $REMOTE_DEST
    fi
}

main
