#!/bin/sh
# Simple host monitor, in BASH/SH
# Work on OpenSuse 15 Linux and Freebsd 11
HOSTS=" PUT HERE A HOST IP OR F.Q.D.N NAME or a List"
COUNT=4
SIZE=8184
for m in $HOSTS
do
  count=$(ping -s $SIZE -c $COUNT $m | grep 'received' | awk -F',' '{ print $2 }' | awk '{ print $1 }')
  if [ $count -eq 0 ]
   then
    logger "$m is down at $(date) $count packets received"
  fi
  if [ $count -eq 1 ]
    then
    logger "PING WARN $m at $(date) 75% losts"
  fi
  logger "Ping count $count to $m"
done
