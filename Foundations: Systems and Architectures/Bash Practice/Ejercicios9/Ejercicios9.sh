#!/bin/sh

# Modify the calculatesFG.bash script so that it calculates factorials in parallel
# Calculate the time consumed now by the script.
bash calculaFG_paralel.bash

time ./calculaFG.bash

time ./calculaFG_paralel.bash
