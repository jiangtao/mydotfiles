#!/bin/sh

server_dir=/mnt/db/backup
local_dir=$HOME/places/work/db_data
user_ip=user@ip
remote_ip=your_local_ip
remote_pass=your_pass
db_name=test

collections="users tasks"
dir=/mnt/your_dir
if [ "$1"  = "export" ]; then
    cd $server_dir

    for table in $collections; do 
            mongoexport --host 127.0.0.1:27017 --authenticationDatabase admin -u mongouser -p $remote_pass -d $db_name -c  $table -q '{"removed": 0}' -o $table.json
    done

elif [ "$1"  = "import" ]; then
    
    if [ "$2" = "down" ]; then
        mkdir -p $local_dir
        scp -r $user_ip:$server_dir $local_dir
    fi

    cd $local_dir/db_data

    for table in $collections; do 
        echo $table
        mongoimport -h 127.0.0.1 --port=27017  -d $db_name -c $table --file $table.json
    done
else 
    echo "input 'bash tools/mongo_clone.sh export' in remote terminal shell"
    echo "input 'bash tools/mongo_clone.sh import' in local terminal shell"
    echo "input 'bash tools/mongo_clone.sh import down' in local terminal shell"
fi



