#!/bin/sh

echo -e "---- udev version ----" > /tmp/void.txt 2>&1
rpm -q udev >> /tmp/void.txt 2>&1

echo -e "\n---- kernel version ----" >> /tmp/void.txt 2>&1
uname -r >> /tmp/void.txt 2>&1

echo -e "\n---- GL versions ----" >> /tmp/void.txt 2>&1
ls -l /usr/lib/libGL* >> /tmp/void.txt 2>&1

echo -e "\n---- is nVidia module loaded? ----" >> /tmp/void.txt 2>&1
/sbin/lsmod | grep nvidia >> /tmp/void.txt 2>&1

echo -e "\n---- is riva module loaded? ----" >> /tmp/void.txt 2>&1
/sbin/lsmod | grep riva >> /tmp/void.txt 2>&1

echo -e "\n---- /dev/nvidia* permissions ----" >> /tmp/void.txt 2>&1
ls -l /dev/nvidia* >> /tmp/void.txt 2>&1

echo -e "\n---- /etc/udev/devices/nvidia* ----" >> /tmp/void.txt
ls -l /etc/udev/devices/nvidia* >> /tmp/void.txt 2>&1

echo -e "\n---- lspci -vv  ----" >> /tmp/void.txt
/sbin/lspci -vv >> /tmp/void.txt 2>&1

if [ -f /etc/udev/permissions.d/50-udev.permissions ]; then
  echo -e "\n---- /etc/udev/permissions.d/50-udev.permissions ----" >> /tmp/void.txt 2>&1
  cat /etc/udev/permissions.d/50-udev.permissions >> /tmp/void.txt 2>&1
fi

if [ -f /tmp/void.txt ]; then
  upld="lcd /tmp
put void.txt"
  msg="void.txt"
fi

if [ -f /etc/X11/xorg.conf ]; then
  upld="$upld
lcd /etc/X11
put xorg.conf"
  msg="$msg, xorg.conf"
fi

if [ -f /etc/X11/XF86Config ]; then
  upld="$upld
lcd /etc/X11
put XF86Config"
  msg="$msg, XF86Config"
fi

if [ -f /var/log/Xorg.0.log ]; then
  upld="$upld
lcd /var/log
put Xorg.0.log"
  msg="$msg, Xorg.0.log"
fi

if [ -f /var/log/XFree86.0.log ]; then
  upld="$upld
lcd /var/log
put XFree86.0.log"
  msg="$msg, XFree86.0.log"
fi

if [ -z "$msg" ]; then
  echo "ERROR: No files found to upload to Void!"
  exit
fi

echo "About to upload these files to void: $msg"
echo "If this is not ok press ^C otherwise"
echo -n "Enter your username for Void's Site: "

read voiduser

if [ -z "$voiduser" ]; then
  echo "ERROR: You must enter a username!"
  exit
fi

ftp -n voidmain.is-a-geek.net <<ENDFTP
quote user anonymous
quote pass $voiduser
verbose
hash
cd uploads
mkdir $voiduser
cd $voiduser
$upld
quit
ENDFTP

echo "Script Finished. Notify Rob Krul of the upload if successful."
