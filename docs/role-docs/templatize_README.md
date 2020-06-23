# Role - Templatize Junos configuration
role name: templatize

## config parameter value that will be templatized
- out-of-band management IP address -> {{ junos_host }}
- out-of-band management network subnet -> {{ mgmt_sub_mask }}
- device hostname -> {{ inventory_hostname }}
- device alias name -> {{ aliase }}
- IntGwy Uplink IP address -> {{ IntUplinkIPAddress }}
- IntGwy Uplink gateway address -> {{ IntUplinkIPNextHop }}
- interface name -> {{ topo[inventory_hostname][interface_alias]["name"] }}
