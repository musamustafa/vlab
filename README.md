# JCL_Ansible_Playbooks
This project is allowing config of Juniper device, Spirent TestCenter, and Ixia IxLoad to be saved, and templatized. It also enables the config to be re-pushed in a new sandbox for the same blueprint(topology).

## Prerequisite
This project works together with HelperVM. HelperVM comes up with ansible inventory files(under /etc/ansible) for the project to consume.


### 1 - Pull config from Juniper device and Ixia/Spirent, and then templatize([get_config_from_device.yml](/docs/playbook-docs/get_config_README.md))
```
ansible-playbook get_config_from_device.yml
```
### 2 - Push the current directory to customized JCL Git Server([push_directory_to_git.yml](/docs/playbook-docs/push_directory_to_git_README.md))
```
ansible-playbook push_directory_to_git.yml --extra-vars "DirName=<YourGitRepositoryName>"
```
### 3 - Push config to Juniper and ixia/spirent devices([install_config_to_device.yml](/docs/playbook-docs/install_config_to_device_README.md))
```  
ansible-playbook install_config_to_device.yml
```
### 4 - Check Python version and install Python3.9.6 if needed.([python_version_check.yml] (/docs/playbook-docs/python_version_check_README.md))
```  
ansible-playbook python_version_check.yml
```  
### 5 - Upgrade Junos Devices.([upgrade_junos.yml](/docs/playbook-docs/upgrade_junos_README.md))
```  
ansible-playbook upgrade_junos.yml --limit <host/group you want to upgrade>
```  

# Ansible roles available in this project
# Roles
- **build_junos_config**
- **push_junos_config**
- **get_junos_config**
- **templatize**
- **create_spirent_session**
- **upload_spirent_xml**
- **load_spirent_xml**
- **reserve_spirent_port**
- **get_spirent_session**
- **save_spirent_config**
- **clear_spirent_session**
- **set_spirent_license**
- **spirent_controller_quit**
- **load_ixia_config**
- **save_ixia_config**
- **save_cyberflood_config**
- **load_cyberflood_config**
- **load_vxlan_nv_host**
- **kvm_vm_running**
- **check_python_version_role**
- **junos_upgrade**




> Default values are defined in /etc/ansible
## build_junos_config

#### Dependencies
No dependency

## push_junos_config

#### Dependencies
This role is dependent on collection **juniper.device > juniper.device.config**

## get_junos_config

#### Dependencies
This role is dependent on collection **juniper.device > juniper.device.config**

## templatize

#### Dependencies
No dependency

## create_spirent_session

#### API
This role is using Spirent ReST API: POST http://host.domain/stcapi/sessions

## upload_spirent_xml

#### API
This role is using Spirent ReST API: PUT http://host.domain/stcapi/files/{{ filename }}

## load_spirent_xml

#### API
This role is using Spirent ReST API: POST http://host.domain/stcapi/perform

## reserve_spirent_port

#### API
This role is using Spirent ReST API:   
Connect to Spirent chassis: POST http://host.domain/stcapi/connections  
Get portlist handle from lab server: GET  http://host.domain/stcapi/objects/project1?children-port  
Assign ports in lab server: PUT  http://host.domain/stcapi/objects/{{ port }}  
Reserve ports: POST http://host.domain/stcapi/perform

## get_spirent_session

#### API
This role is using Spirent ReST API: GET http://host.domain/stcapi/sessions

## save_spirent_config

#### API
This role is using Spirent ReST API: POST http://host.domain/stcapi/perform

## clear_spirent_session

#### API
This role is using Spirent ReST API: DELETE http://host.domain/stcapi/sessions/{{ session_id }}

## set_spirent_license

#### API
This role is using Spirent ReST API:  
Get license_parent object: GET http://host.domain/stcapi/objects/system1?children-licenseservermanager  
Get license object: GET http://host.domain/stcapi/objects/{{ license_parent }}?children  
Set Spirent license server IP: PUT http://host.domain/stcapi/objects/{{ license_object }}


## spirent_controller_quit

#### API
This role is using Spirent ReST API: DELETE http://host.domain/stcapi/sessions/{{ session_id }}?false

## load_ixia_config

#### API
This role is using Ixia ReST API  
Upload config file to REST server: POST http://host.domain/api/v1/sessions/1/ixnetwork/files?filename=ixia.ixncfg  
Load config file: POST http://host.domain/api/v1/sessions/1/ixnetwork/operations/loadconfig  
Assign Ports: POST http://host.domain/api/v1/sessions/1/ixnetwork/operations/assignports

## save_ixia_config

#### API
This role is using Ixia ReST API
Save config as ixncfg file on REST server: POST http://host.domain/api/v1/sessions/1/ixnetwork/operations/saveconfig

## save_cyberflood_config

#### API
This role is using Cyberflood ReST API:
Authenticate: POST https://host.domain/api/v2/token
Get all tests: GET https://host.domain/api/v2//tests
Create test export: POST https://host.domain/api/v2//tests/exports
Download test export: GET https://host.domain/api/v2//tests/exports/{{ export_ret.json.id }}/download


## load_cyberflood_config

#### API
This role is using Cyberflood ReST API:
authenticate: POST https://host.domain/api/v2/token
Upload tests to cyberflood: POST {{ api_url }}tests/imports?type=avn' --header 'Accept: application/json' --header 'Content-Type: multipart/form-data' --header 'Authorization: Bearer {{ auth_ret.json.token }}



## junos_upgrade

#### Dependencies
Read the README specific to the playbook. The Playbook might Fail.
This role is dependent on collection **juniper.device > juniper.device.rpc** and **juniper.device > juniper.device.facts**
