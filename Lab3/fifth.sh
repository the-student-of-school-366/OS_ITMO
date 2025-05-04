#!/bin/bash

mkfifo pipe

bash fifthhan.sh & bash fifthgen.sh
rm pipe