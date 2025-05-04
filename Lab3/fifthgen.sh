#!/bin/bash

while true; do
        read line
        echo "$line" > pipe
        if [[ "$line" == "QUIT" ]]; then
                exit
        fi

        if [[ "$line" != [\*+] && !"$line" =~ ^[0-9]$ ]]; then
                exit 1
        fi
done
