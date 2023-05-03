# Playbook - Upgrade Junos device

Playbook name: upgrade_junos.yml

When this playbook is running against Junos devices, it will upgrade the scoped junos Devices with the selected images. <br>
<em>Restrictions:  Physical devices only. Supports vmhost and regular device upgrades.</em>
<em>Restrictions:  The Playbook might timeout and the upgrade might timeout because of no response from RPC. Run ls -l /var/tmp and check if the file is being copied.</em>
<em>Workaround:  run export ```ANSIBLE_PERSISTENT_COMMAND_TIMEOUT=1800``` to increase the timeout.</em>

## Requirements and Role Dependencies

This Playbook relies on the following roles

- junos_upgrade
