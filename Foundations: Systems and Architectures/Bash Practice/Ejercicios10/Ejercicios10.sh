#!/bin/sh

# Set the execution of the script 'calculaFG_paralel.bash' in core number 1
taskset -c 1 ./calculaFG_paralel.bash


