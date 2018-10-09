#!/bin/sh
#yet another gateway changer on Dualwan Gnu/Linux or FreeBSD.
#hope this working on your installation

PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
ROUTE=/sbin/route

# Gateway to be tested
GW1=192.168.255.1 # ip gateway of network 1
GW2=192.168.254.1 # ip gateway of network 2

#Ip of my interfaces
WAN1=192.168.255.2 # ip of interface 1
WAN2=192.168.254.2 # ip of interface 2

#trying numbers of pings
TENTATIVAS=3

#NUM DE PACOTES RECEBIDOS
# Could this script run without this ? I guess so
PPMAX=3;

if (netstat -nr4 | grep default | grep -c $GW1 > /dev/null)
then
  DWAN1=1
  DWAN2=0
else
  DWAN1=0
  DWAN2=1
fi

TGW1=$(ping -S $WAN1 -c $TENTATIVAS $GW1 | grep 'received' | awk -F',' '{ print $2 }' | awk '{ print $1 }')
TGW2=$(ping -S $WAN2 -c $TENTATIVAS $GW2 | grep 'received' | awk -F',' '{ print $2 }' | awk '{ print $1 }')

if [ $TGW1 -ge $PPMAX ] && [ $DWAN1 -eq 1 ]
then
   echo "GW1 Ok, default route GW1"
   exit
elif [ $TGW1 -ge $PPMAX ] && [ $DWAN2 -eq 1 ]
then
    echo "GW1 OK, deactiving GW2 $(date)"
    logger "GW1 OK, deactiving GW2 $(date)"
    $ROUTE del default
    $ROUTE add default gw $WAN1
        exit                                                                               
fi

if [ $TGW2 -ge $PPMAX ] && [ $DWAN2 -eq 1 ]
then
    echo "GW2 Ok, default route GW2"
    exit
elif [ $TGW2 -ge $PPMAX ] && [ $DWAN1 -eq 1 ]
then
    echo "GW2 OK, GW1 OFF, change route to GW2 $(date)"
    logger "GW2 OK, GW1 OFF, change route to GW2 $(date)"
    $ROUTE del default
    $ROUTE add default gw $WAN2
    exit
fi
