#!/bin/bash

if [ -z "$1" ]; then
    #判断是否输入文件名称
    echo "请输入需要监控的脚本的绝对路径"
    exit 2
elif [ -x "$1" ]; then
    #判断文件是否存在并且可执行
    echo "文件不存在或不可执行"
    exit 2
else
    cmd=$(echo ${1##*/})
fi
while true; do
    st=$(ps -ef | grep "$cmd" | grep -v grep | grep -v "$0")
    if [ -z "$st" ]; then
        echo $1 "脚本终止，即将重启。"
        sh $1
    else
        echo $1 "脚本正在运行"
    fi
    sleep 0.5
done
