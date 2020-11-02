#!/bin/bash
if [ "$1" == "" ]; then
    echo "请输入keyword"
    exit 2
fi
test ! -d "$2" && echo -e "$2 不存在." && exit 0
echo -e "\n---------------result:---------------\n"
file_count=0
#file_list为需要查找的文件列表
file_list=$(ls -R $2 2>/dev/null | grep -v '^$')
for file_name in $file_list; do
    #去除带：的路径
    temp=$(echo $file_name | sed 's/:.*$//g')
    #因为目录去除了：，所以判断是不是路径
    if [ "$file_name" != "$temp" ]; then
        cur_dir=$temp
    else
    #将 $cur_dir/$file_name作为字符串传给grep
        temp=$(echo "$cur_dir/$file_name"|grep $1 2>/dev/null)
        if [ "$temp" != "" ]; then
            echo sucess $cur_dir/$file_name
            let file_count++
        fi
    fi

done
echo "Files Total: $file_count"
