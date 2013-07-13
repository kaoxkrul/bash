#!/bin/bash

############################################
# Bash Screen Example
# by Rob Krul
#
# Note: Bash is limited to integer math
# Use Korn Shell if you want floating point
############################################

################
# Subroutines
################

function starscreen() {

  xstart=12
  ystart=5
  x=$xstart
  y=$ystart
  z=0
  stars=""

  clear
  while ((z<40))
  do
    ((y=y+1))
    ((x=x+1))
    stars="$stars\033[${y};${x}H*" 
    if ((y==20)); then
      ((z=z+4))
      ((y=ystart))
      ((x=xstart+z))
    fi
  done
  echo -n -e "$stars" 

}

function voidscreen () {

  starscreen
  echo -n -e "\033[11;24H[==========================]" \
             "\033[12;24H[=   Celcius/Fahrenheit   =]" \
             "\033[13;24H[=      by Rob Krul      =]" \
             "\033[14;24H[==========================]" \
             "\033[1;1H" 
  sleep 2

}

function getcelcius () {

  starscreen
  echo -n -e "\033[12;24H[==========================]" \
             "\033[13;24H[= Enter Celcius:         =]" \
             "\033[14;24H[==========================]" \
             "\033[13;42H" 
  read celcius

}

function getfahrenheit () {

  echo -n -e "\033[12;24H[==========================]" \
             "\033[13;24H[= Enter Fahrenheit:      =]" \
             "\033[14;24H[==========================]" \
             "\033[13;45H" 
  read fahrenheit

}

function displayfahrenheit () {

  ((fahrenheit=celcius*9/5+32))
  echo -n -e "\033[12;24H[==========================]" \
             "\033[13;24H[=                        =]" \
             "\033[14;24H[==========================]" \
             "\033[13;33H${celcius}C = ${fahrenheit}F" \
             "\033[1;1H" 
  sleep 4

}

function displaycelcius () {

  ((celcius=(fahrenheit-32)*5/9))
  echo -n -e "\033[12;24H[==========================]" \
             "\033[13;24H[=                        =]" \
             "\033[14;24H[==========================]" \
             "\033[13;33H${fahrenheit}F = ${celcius}C" \
             "\033[1;1H" 
  sleep 4

}

function byescreen () {

  echo -n -e "\033[12;24H[==========================]" \
             "\033[13;24H[=        bye bye!        =]" \
             "\033[14;24H[==========================]" \
             "\033[1;1H" 
  sleep 1
  clear
  exit

}

################
# Main Program
################
voidscreen
getcelcius
displayfahrenheit
getfahrenheit
displaycelcius
byescreen
