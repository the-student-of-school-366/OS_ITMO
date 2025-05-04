#!/bin/bash

res=1
oper="+"
(tail -f pipe) | while true; do
         read LINE
         case "$LINE" in
                QUIT)
                        echo "exit"
                        killall tail
                        exit
                ;;
                "*")
                        oper=*
                        echo -e "\033[36m multi-mode \033[37m"
                ;;
                "+")
                        oper="$LINE"
                        echo -e "\033[36m plus-mode \033[37m"

                ;;
                *)
                        if [[ "$LINE" =~ ^[0-9]$ ]]; then
                                res=$(($res $oper $LINE))
                                echo $res
                        else
                                echo "Argument Exception"
                                exit 1
                        fi
        esac
done