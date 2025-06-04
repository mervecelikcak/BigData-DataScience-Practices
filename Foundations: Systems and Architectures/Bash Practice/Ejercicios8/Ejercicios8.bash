#!/bin/bash

# This script is used to display the average time after compiling calculaFG script 4 times

# Create a variable to store the number of times to compile the script
declare num_of_times=4

# Compile calculaFG script 4 times and store the time in a variable
start=`date +%s%3N`
for i in {1..num_of_times};do
    $(bash ./calculaFG.bash)
done
end=`date +%s%3N`

# Calculate the average time and Display it in seconds as float
sum=$((end-start))
avg=$(echo "scale=3; $sum/$num_of_times/1000" | bc)
echo "Average Time: $avg seconds"
