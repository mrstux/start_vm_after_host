#!/usr/bin/env bash

# this script will wait for a given hosts ssh port to activate
# https://serverfault.com/a/995377

HOST=$1
PORT=$2
TIMEOUT=$3

if [ -z "$1" ]
  then
    echo "Missing argument for host."
    exit 1 
fi

if [ -z "$2" ]
  then
    echo "Missing argument for ssh port."
    exit 1 
fi
echo "polling to see that host is up and ssh is ready"
RESULT=1 # 0 upon success
while :; do 
    echo "waiting for host ssh response, ${TIMEOUT} check iterations remaining..."
    # https://serverfault.com/questions/152795/linux-command-to-wait-for-a-ssh-server-to-be-up
    # https://unix.stackexchange.com/questions/6809/how-can-i-check-that-a-remote-computer-is-online-for-ssh-script-access
    # https://stackoverflow.com/questions/1405324/how-to-create-a-bash-script-to-check-the-ssh-connection
    status=$(ssh -o BatchMode=yes -o ConnectTimeout=5 ${HOST} -p ${PORT} echo ok 2>&1)
    RESULT=$?
    if [ $RESULT -eq 0 ]; then
        # this is not really expected unless a key lets you log in
        echo "connected ok"
        break
    fi
    if [ $RESULT -eq 255 ]; then
        # connection refused also gets you here
        if [[ $status == *"Permission denied"* || $status == *"verification failed"* ]] ; then
            # permission denied, or host key verification failed indicates the ssh link is okay
            echo "host response found"
            break
        fi
    fi
    TIMEOUT=$((TIMEOUT-1))
    if [ $TIMEOUT -eq 0 ]; then
        echo "timed out"
        # error for jenkins to see
        exit 1 
    fi
    sleep 5
done
