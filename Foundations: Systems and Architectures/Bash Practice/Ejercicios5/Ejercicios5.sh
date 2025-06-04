#!/bin/sh

##Modelo de procesador

cat /proc/cpuinfo

##Cantidad de memoria libre (en GB)

free -g -h -t

##Cantidad de disco libre (en GB)

df -h --total

##Cantidad de disco libre (en GB) para la partición /

df -h / | awk 'NR==2 {print $4}'

