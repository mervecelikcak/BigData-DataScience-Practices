#!/bin/sh


# Display the number of files with that extension txt in the directory
find . -name "*.txt" -type f | wc -l

ls *.txt | wc -l

