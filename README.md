# Stux's TrueNAS Scripts

[github.com/mrstux/truenas_scripts](https://github.com/mrstux/truenas_scripts)
[TrueNAS Resource Post & Discussion](https://www.truenas.com/community/resources/scripts-to-start-vm-when-another-host-vm-finishes-booting.249/)

Some simple TrueNAS scripts. Not all are my own work.

I clone these scripts into tank/server/scripts in my pools

## start_vm_after_host

Starts a vm after another host comes online

I use this to activate my VM's after my pfSense VM finishes starting. I call the script as a post-init command with my pfSense VM's IP and the vm name ie

`/mnt/tank/server/scripts/truenas_scripts/start_vm_after_host.sh <pfsense ip> 22 ssh <vm name>`

`ssh` can also be `generic` for a tcp check

## start_vm_by_name

starts a vm by name

## stop_vm_by_name

stops a vm by name

## wait_for_ssh

waits for a host's ssh port to begin responding

## print_vm_ids

prints a list of all vm names and their ids

## Other Scripts

[Hybrid Fan Controller](https://github.com/mrstux/hybrid_fan_control)

[Spearfoot's Disk Burnin and Testing](https://github.com/Spearfoot/disk-burnin-and-testing)

