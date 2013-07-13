#!/bin/ksh

############################################
# Korn Shell Screen Example
# by Rob Krul
#
# Note: The "real" ksh93 must be installed.
# pdksh will not do floating point math.
# You can get the real ksh93 here:
# http://www.kornshell.com/
############################################

typeset -F2 celcius
typeset -F2 fahrenheit

################
# Subroutines
################

function starscreen {

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
  /bin/echo -n -e "$stars" 

}

function voidscreen {

  starscreen
  /bin/echo -n -e "\033[11;24H[==========================]" \
                  "\033[12;24H[=   Celcius/Fahrenheit   =]" \
                  "\033[13;24H[=      by Rob Krul      =]" \
                  "\033[14;24H[==========================]" \
                  "\033[1;1H" 
  sleep 2

}

function getcelcius {

  starscreen
  /bin/echo -n -e "\033[12;24H[==========================]" \
                  "\033[13;24H[= Enter Celcius:         =]" \
                  "\033[14;24H[==========================]" \
                  "\033[13;42H" 
  read celcius

}

function getfahrenheit {

  /bin/echo -n -e "\033[12;24H[==========================]" \
                  "\033[13;24H[= Enter Fahrenheit:      =]" \
                  "\033[14;24H[==========================]" \
                  "\033[13;45H" 
  read fahrenheit

}

function displayfahrenheit {

  ((fahrenheit=celcius*9.0/5.0+32.0))
  /bin/echo -n -e "\033[12;24H[==========================]" \
                  "\033[13;24H[=                        =]" \
                  "\033[14;24H[==========================]" \
                  "\033[13;30H${celcius}C = ${fahrenheit}F" \
                  "\033[1;1H" 
  sleep 4

}

function displaycelcius {

  ((celcius=(fahrenheit-32.0)*5.0/9.0))
  /bin/echo -n -e "\033[12;24H[==========================]" \
                  "\033[13;24H[=                        =]" \
                  "\033[14;24H[==========================]" \
                  "\033[13;30H${fahrenheit}F = ${celcius}C" \
                  "\033[1;1H" 
  sleep 4

}

function byescreen {

  /bin/echo -n -e "\033[12;24H[==========================]" \
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
