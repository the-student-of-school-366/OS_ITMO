#!/bin/bash

oper="+"
function usr1 {
        echo -e "\033[36m plus-mode \033[37m"
        oper="+"
}

function usr2 {
        echo -e "\033[36m multi-mode \033[37m"
        oper=*
}
function term {
        echo exit;
        exit 0
}

trap 'usr1' USR1
trap 'usr2' USR2
trap 'term' SIGTERM

res=1
while true; do
        res=$(($res $oper "2"))
        echo $res
        sleep 1
done