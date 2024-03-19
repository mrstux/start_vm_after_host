#!/bin/env bash

# script waits for the SSH server to activate on the IP, then starts the designated VM
# in my case this is used to ensure that pfSense is started before starting other VMs
#
# ie, add a post init command `/path/to/script <ip> 22 <vm_name>`
#
# tested on TrueNAS SCALE 23.10.2
#
# Author: Stuart Espey - 2024-03-19
# https://github.com/mrstux/truenas_scripts

if [ $# -ne 3 ] ; then
    echo "Syntax: `basename $0` host host_ssh_port vm_name"
    exit 0
fi

sshIp=$1
sshPort=$2
vmName=$3

scriptDir="$( dirname -- "$BASH_SOURCE"; )";
pingSshTool="$scriptDir/wait_for_ssh.sh"
startVmByNameTool="$scriptDir/start_vm_by_name.sh"

RESULT=1

# wait for ssh to come up
$pingSshTool $sshIp $sshPort
RESULT=$?

if [ $RESULT -eq 0 ]; then
    # pfsense is up
    echo "${sshIp}:${sshPort} is responsive, starting VM: $vmName"
    $startVmByNameTool $vmName
    RESULT=$?
fi

exit $RESULT
