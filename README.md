# Stux's TrueNAS Scripts

[https://github.com/mrstux/truenas_scripts](https://github.com/mrstux/truenas_scripts)

Some simple TrueNAS scripts. Not all are my own work.

I clone these scripts into tank/server/scripts in my pools

## start_vm_after_host

Starts a vm after another host comes online

I use this to activate my VM's after my pfSense VM finishes starting. I call the script as a post-init command with my pfSense VM's IP and the vm name ie

`/mnt/tank/server/scripts/truenas_scripts/start_vm_after_host.sh <pfsense ip> 22 <vm name>`

## start_vm_by_name

starts a vm by name

## wait_for_ssh

waits for a host's ssh port to begin responding

## Other Scripts

[Hybrid Fan Controller](https://github.com/mrstux/hybrid_fan_control)

