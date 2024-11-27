#!/usr/bin/env bash

# this script will wait for a given hosts TCP port to start listening
# https://stackoverflow.com/questions/4922943/test-if-remote-tcp-port-is-open-from-a-shell-script/14701003#14701003

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
    echo "Missing argument for port."
    exit 1 
fi
echo "polling to see that host is up and port is listening"
RESULT=1 # 0 upon success
while :; do 
    echo "waiting for host port to come up, ${TIMEOUT} check iterations remaining..."
    status=$(nc -z ${HOST} ${PORT} 2>&1)
    RESULT=$?
    if [ $RESULT -eq 0 ]; then
        echo "connected ok"
        break
    fi
    if [ $RESULT -eq 1 ]; then
        echo "port not listening"
    fi
    TIMEOUT=$((TIMEOUT-1))
    if [ $TIMEOUT -eq 0 ]; then
        echo "timed out"
        # error for jenkins to see
        exit 1 
    fi
    sleep 5
done
