
#!/bin/sh

server_dir=/mnt/db/backup
local_dir=$HOME/places/work/db_data
user_ip=user@ip
remote_ip=your_local_ip
remote_pass=your_pass
db_name=test

# node tools/cloneAllDb.sh export 在远端运行，导出指定的目录
if [ "$1"  = "export" ]; then 
    mongodump --gzip --host $remote_ip --authenticationDatabase admin -u mongouser -p $remote_pass -d $db_name -o $server_dir
    # node tools/cloneAllDb.sh import down 在本地运行，把远端导出的压缩文件，
    # `down`表示下载到本地指定文件
    # import 将文件导入到数据库中
elif [ "$1"  = "import" ]; then
    if [ "$2" = "down" ]; then
        mkdir -p $local_dir
        scp -r $user_ip:$server_dir $local_dir
    fi
    mongorestore --gzip --dir $local_dir/backup
    echo 'import'
else 
    echo "node tools/cloneAllDb.sh import"
    echo "node tools/cloneAllDb.sh import down"
    echo "node tools/cloneAllDb.sh export"
fi