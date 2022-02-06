#!/bin/bash

power=$1

power=`echo "scale = 10; $power/1000" | bc`

#### Calculating Numerator & Denominator for convertong to Base 10
numerator=$(echo "scale = 10; l($power)" | bc -l)
denominator=2.3026

#### final answer
f_decible=$(echo "scale = 10; 10*($numerator/$denominator)" | bc -l)
echo $f_decible
