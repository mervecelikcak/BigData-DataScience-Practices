#!/bin/sh

# Given the file nombres.txt obtain a listing of the 5 most repeated names along with their number of occurrences in the file.
sort nombres.txt | uniq -c | sort -nr | head -5
