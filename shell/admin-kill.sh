echo "try kill all process running on port:4000"
trykill(){
    kill -9 $(lsof -i:4000 -t)
    if [ $? -eq 0 ];
    then
        echo 4000端口进程被成功停止
    else
        echo 4000端口未处于被占用状态
    fi
}
trykill