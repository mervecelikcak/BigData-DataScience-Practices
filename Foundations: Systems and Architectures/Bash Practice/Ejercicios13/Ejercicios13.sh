#!/bin/sh

# create a file cron
crontab -e
# use a line in crontab to run 'Ejercicios5.sh' every friday on 14:00
0 14 * * 5 /media/sf_Prctica_1/Ejercicios13/Ejercicios5.sh
# save the output of the script in a file 'Ejercicios13_Output.txt'
0 14 * * 5 /media/sf_Prctica_1/Ejercicios13/Ejercicios5.sh > /media/sf_Prctica_1/Ejercicios13/Ejercicios13_Output.txt
