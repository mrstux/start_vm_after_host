#!/bin/env bash

# script waits for the SSH server or a generic port to activate on the IP, then
# starts the designated VM in my case this is used to ensure that pfSense is
# started before starting other VMs
#
# ie, add a post init command `/path/to/script <ip> 22 ssh 30 <vm_name>`
# or                          `/path/to/script <ip> 3128 generic 30 <vm_name>`
# e.g. if squid running on 192.168.0.2 start myvm:
#                             `/path/to/script 192.168.0.2 3128 generic 30 myvm`
# note that 30 is the amount of 5 second intervals the port will be checked
# before checking times out and the VM not started - so 150 secs in all.
#
# tested on TrueNAS SCALE 23.10.2
#
# Author: Stuart Espey - 2024-03-19
# https://github.com/mrstux/truenas_scripts

if [ $# -ne 5 ] ; then
    echo "Syntax: `basename $0` host port port_type timeout_iterations vm_name"
    exit 0
fi

sshIp=$1
sshPort=$2
portType=$3
timeout=$4
vmName=$5

scriptDir="$( dirname -- "$BASH_SOURCE"; )";
pingSshTool="$scriptDir/wait_for_ssh.sh"
pingPortTool="$scriptDir/wait_for_generic_port.sh"
startVmByNameTool="$scriptDir/start_vm_by_name.sh"

RESULT=1

# wait for ssh or generic TCP port to come up
if [ "$portType" = "ssh" ]; then
    $pingSshTool $sshIp $sshPort $timeout
    RESULT=$?
elif [ "$portType" = "generic" ]; then
    $pingPortTool $sshIp $sshPort $timeout
    RESULT=$?
else
    echo "Please specify port type of ssh or generic."
    RESULT=1
fi

if [ $RESULT -eq 0 ]; then
    # pfsense is up
    echo "${sshIp}:${sshPort} is responsive, starting VM: $vmName"
    $startVmByNameTool $vmName
    RESULT=$?
fi

exit $RESULT
