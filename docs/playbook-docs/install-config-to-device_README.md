# Playbook - Install config to Juniper, Spirent and Ixia

Playbook name: install-config-to-device.yml

When this playbook is running against Junos devices, it builds the config stored in config_templatized into folder ansible_build, and then pushes the relevant config file there to the device

when this playbook is running on Spirent TestCenter, it clears the current active spirent session if there is any, creates a new spirent session, loads the spirent.xml config to session, set spirent license server address, reserves spirent ports

When this playbook is running on IxLoad, it uploads ixia.ixncfg config file, loads the uploaded config, and assign tester ports

## Requirements and Role Dependencies

This Playbook relies on the following roles

- build-junos-config
- push-junos-config
- get-spirent-session
- clear-spirent-session
- create-spirent-session
- upload-spirent-xml
- load-spirent-xml
- set-spirent-license
- reserve-spirent-port
- spirent-controller-quit
- load-ixia-config
