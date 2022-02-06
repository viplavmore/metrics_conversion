#!/bin/bash

power=$1

power=`echo "scale = 10; $power/1000" | bc`

#### final answer
f_decible=$(echo "scale = 10; 10*$power" | bc -l)
echo $f_decible
