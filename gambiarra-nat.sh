#!/bin/bash
# simple socat usages
#open an udp port and forward to another ip
socat UDP4-RECVFROM:53,fork UDP4-SENDTO:192.168.0.1:53
# open an tcp port and forward to another ip
socat TCP-LISTEN:443,fork TCP:192.168.0.1:443


# du command for hidden files
du -hs .[^.]*
