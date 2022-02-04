# Playbook - Get config from device and templatize the config

Playbook name: get-config-from-device.yml

When this playbook is running against Junos devices, it will get the configurations from device and replace certain config parameter with the variable name, ie. templatize, the templatized configs will be saved to folder **config_templatized**. <br>
<em> for example. the junos device gateway address will be replaced with {{ mgmt_sub_gw }}</em>

when this playbook is running on Spirent or Ixia, it will get the traffic configuration and save it as file sprirent.xml/ixia.ixncfg

## Requirements and Role Dependencies

This Playbook relies on the following roles

- get_junos_config
- [templatize](/docs/role-docs/templatize_README.md)
- check_python_version_role
- save_spirent_config
- get_spirent_session
- spirent_controller_quit
- save_ixia_config
- save_cyberflood_config
