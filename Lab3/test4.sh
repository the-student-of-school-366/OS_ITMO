#!/bin/bash

function infloop {
        res=0
        while true
        do
                res=$res
        done
}

infloop& pid1=$!
infloop& pid2=$!
infloop& pid3=$!

ni=10
while true; do
        cpu=$(ps -p "$pid1" -o %cpu | tail -1 | awk '{printf "%.0f", $0}')
        if [ "$cpu" -gt 10 ]; then
                renice "+$ni" -p $pid1
                ni=$(($ni++))
        fi
done &

kill -9 $pid3
top -p $pid1,$pid2,$pid3