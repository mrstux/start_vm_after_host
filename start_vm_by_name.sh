#!/usr/bin/env bash
# start VM by name
# platform: TrueNAS CORE-12 (works on TrueNAS SCALE 23.10.2)
# https://www.truenas.com/community/threads/how-start-vm-from-shell-or-script.87075/post-617371

PATH=/bin:/usr/bin:/usr/local/bin

if [ $# -eq 0 ] ; then
    echo "Syntax: `basename $0` vmname"
    exit 0
fi

# get VM name
VMNAME=$1

# get VM ID
ID=`midclt call vm.query |
     jq --raw-output '[.[] | { (.name): .id } ]' |
     grep $VMNAME |
     sed 's/.*\:\(.*\)/\1/'`

echo "Start '$VMNAME': id=$ID"
midclt call vm.start $ID
