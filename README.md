### 1 - Pull config from Juniper device and Ixia/Spirent and then templatize
```
ansible-playbook get-config-from-device.yml
```
### 2 - Push the current directory to customized JCL Git Server
```
ansible-playbook push-directory-to-git.yml --extra-vars "DirName=<YourGitRepositoryName>"
```
### 3 - Push config to Juniper and ixia/spirent devices
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
This role is using Spirent ReST API: POST http://host.domain/stcapi/connections
                                     GET  http://host.domain/stcapi/objects/project1?children-port
									 PUT  http://host.domain/stcapi/objects/{{ port }}
									 POST http://host.domain/stcapi/perform

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
This role is using Spirent ReST API: GET http://host.domain/stcapi/objects/system1?children-licenseservermanager , return license_parent
                                     GET http://host.domain/stcapi/objects/{{ license_parent }}?children, return license_object
                                     PUT http://host.domain/stcapi/objects/{{ license_object }}


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
