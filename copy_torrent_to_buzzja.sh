#!/bin/bash

REMOTE_DEST="buzzja.mine.nu:~/torrents"
LOCAL_TORRENT_SOURCE="$HOME/Downloads"

# Simple copy torrent files
scp $LOCAL_TORRENT_SOURCE/*.torrent $REMOTE_DEST && rm $LOCAL_TORRENT_SOURCE/*.torrent
