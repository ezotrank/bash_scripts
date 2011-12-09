#!/bin/bash

DEV_DIR=$HOME/develop
PROJECT_DIR=$DEV_DIR/.project_dir

function add(){
    pwd=`pwd`
    name=$(basename $pwd)
    if [[ $(grep "^$name " $PROJECT_DIR) ]]; then
	echo "This dir `pwd` already exists, but I can raplace path"
	sed -i.bak "/^$name .*/d" $PROJECT_DIR
    fi
    echo -e "\n$name $pwd" >> $PROJECT_DIR
    sed -i.bak "/^$/d" $PROJECT_DIR
}

function get_path(){
    path=$(grep "^$1 " $PROJECT_DIR|awk '{print $2}')
    if [ $path ]; then
	echo $path
    else
	echo $HOME
    fi
}

case "$1" in
    "add")
	add
	;;
    "show")
	cat $PROJECT_DIR
	;;
    *)
	emacs --title EmacsDev --chdir `get_path $1` &>/dev/null &
	;;
esac

