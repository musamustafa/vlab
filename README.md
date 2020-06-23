# JCL_Ansible_Playbooks
This project is allowing config of Juniper device, Spirent TestCenter, and Ixia IxLoad to be saved, and templatized. It also enables the config to be re-pushed in a new sandbox for the same blueprint(topology).

## Prerequisite
This project works together with HelperVM. HelperVM comes up with ansible inventory files(under /etc/ansible) for the project to consume.


### 1 - Pull config from Juniper device and Ixia/Spirent, and then templatize([get-config-from-device.yml](/docs/playbook-docs/get-config_README.md))
```
ansible-playbook get-config-from-device.yml
```
### 2 - Push the current directory to customized JCL Git Server([push-directory-to-git.yml](/docs/playbook-docs/push-directory-to-git_README.md))
```
ansible-playbook push-directory-to-git.yml --extra-vars "DirName=<YourGitRepositoryName>"
```
### 3 - Push config to Juniper and ixia/spirent devices([install-config-to-device.yml](/docs/playbook-docs/install-config-to-device_README.md))
```  
ansible-playbook install-config-to-device.yml
```

# Ansible roles available in this project
# Roles
- **build-junos-config**
- **push-junos-config**
- **get-junos-config**
- **templatize**
- **create-spirent-session**
- **upload-spirent-xml**
- **load-spirent-xml**
- **reserve-spirent-port**
- **get-spirent-session**
- **save-spirent-config**
- **clear-spirent-session**
- **set-spirent-license**
- **spirent-controller-quit**
- **load-ixia-config**
- **save-ixia-config**

> Default values are defined in /etc/ansible
## build-junos-config

#### Dependencies
No dependency

## push-junos-config

#### Dependencies
This role is dependent of **Juniper.junos > juniper_junos_config**

## get-junos-config

#### Dependencies
This role is dependent of **Juniper.junos > juniper_junos_config**

## templatize

#### Dependencies
No dependency

## create-spirent-session

#### API
This role is using Spirent ReST API: POST http://host.domain/stcapi/sessions

## upload-spirent-xml

#### API
This role is using Spirent ReST API: PUT http://host.domain/stcapi/files/{{ filename }}

## load-spirent-xml

#### API
This role is using Spirent ReST API: POST http://host.domain/stcapi/perform

## reserve-spirent-port

#### API
This role is using Spirent ReST API:   
Connect to Spirent chassis: POST http://host.domain/stcapi/connections  
Get portlist handle from lab server: GET  http://host.domain/stcapi/objects/project1?children-port  
Assign ports in lab server: PUT  http://host.domain/stcapi/objects/{{ port }}  
Reserve ports: POST http://host.domain/stcapi/perform

## get-spirent-session

#### API
This role is using Spirent ReST API: GET http://host.domain/stcapi/sessions

## save-spirent-config

#### API
This role is using Spirent ReST API: POST http://host.domain/stcapi/perform

## clear-spirent-session

#### API
This role is using Spirent ReST API: DELETE http://host.domain/stcapi/sessions/{{ session_id }}

## set-spirent-license

#### API
This role is using Spirent ReST API:  
Get license_parent object: GET http://host.domain/stcapi/objects/system1?children-licenseservermanager  
Get license object: GET http://host.domain/stcapi/objects/{{ license_parent }}?children  
Set Spirent license server IP: PUT http://host.domain/stcapi/objects/{{ license_object }}


## spirent-controller-quit

#### API
This role is using Spirent ReST API: DELETE http://host.domain/stcapi/sessions/{{ session_id }}?false

## load-ixia-config

#### API
This role is using Ixia ReST API  
Upload config file to REST server: POST http://host.domain/api/v1/sessions/1/ixnetwork/files?filename=ixia.ixncfg  
Load config file: POST http://host.domain/api/v1/sessions/1/ixnetwork/operations/loadconfig  
Assign Ports: POST http://host.domain/api/v1/sessions/1/ixnetwork/operations/assignports

## save-ixia-config

#### API
This role is using Ixia ReST API
Save config as ixncfg file on REST server: POST http://host.domain/api/v1/sessions/1/ixnetwork/operations/saveconfig
