# Role - Templatize Junos configuration
role name: templatize

## config parameter value that will be templatized
- out-of-band management IP address -> {{ junos_host }}
- out-of-band management network subnet -> {{ mgmt_sub_mask }}
