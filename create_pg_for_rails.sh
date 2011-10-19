#!/bin/bash

usage()
{
cat << EOF
usage: $0 options

Examples: $0 -u user1 -p my_password -n some_project_name

OPTIONS:
   -u      Username
   -p      Password
   -n      Project name
   -h      Show this help
EOF
}



while getopts "hu:p:n:" OPTION
do
     case $OPTION in
         h)
             usage
             exit 1
             ;;
         u)
             USERNAME=$OPTARG
             ;;
         p)
             PASSWORD=$OPTARG
             ;;
         n)
             DBNAME=$OPTARG
             ;;
         ?)
             usage
             exit
             ;;
     esac
done

# function create_tmp_sql_file {
#     file_name="create_db_$RANDOM.sql"
#     touch /tmp/$file_name
# }

function write_config {
    cat << EOF
create role $USERNAME with createdb login password '$PASSWORD';
create database ${DBNAME}_development owner $USERNAME;
create database ${DBNAME}_production owner $USERNAME;
create database ${DBNAME}_test owner $USERNAME;
EOF
}


if [ -z "$USERNAME" ] || [ -z "$PASSWORD" ]
then
     usage
     exit 1
else
    # create_tmp_sql_file
    write_config
fi
