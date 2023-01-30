#!/bin/bash
# simple socat usages
#open an udp port and forward to another ip
socat UDP4-RECVFROM:53,fork UDP4-SENDTO:192.168.0.1:53
# open an tcp port and forward to another ip
socat TCP-LISTEN:443,fork TCP:192.168.0.1:443


# du command for hidden files
du -hs .[^.]*

# findmax show the most used hidden and normal in size files, directories 
alias findmax='find -maxdepth 1 -mindepth 1 -exec du -hs {} + | sort -h'

 # find directories and list, formating output 4 dir by lines
 #not tested with directories with space and special chars on their names
 find -maxdepth 1 -mindepth 1 -type d | sed 's/\.\///g'|  paste -d ' ' - - - -

# showing off alle between two patterns with awk
awk '/^PADRAO1/,/PADRAO2/' file.txt
