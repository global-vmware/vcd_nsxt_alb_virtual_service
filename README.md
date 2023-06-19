# Terraform VMware Cloud Director NSX-T ALB Virtual Service Module

This Terraform module will deploy an NSX-T ALB (Advanced Load Balancer) Virtual Service into an existing VMware Cloud Director (VCD) environment. This module can be used to provsion new ALB Virtual Services into [Rackspace Technology SDDC Flex](https://www.rackspace.com/cloud/private/software-defined-data-center-flex) VCD Data Center Regions.

## Requirements

| Name      | Version |
|-----------|---------|
| terraform | ~> 1.2  |
| vcd       | ~> 3.8  |

## Resources

| Name                                                                                                                                 | Type         |
|--------------------------------------------------------------------------------------------------------------------------------------|--------------|
| [vcd_vdc_group](https://registry.terraform.io/providers/vmware/vcd/latest/docs/data-sources/vdc_group)                               | Data Source  |
| [vcd_nsxt_edgegateway](https://registry.terraform.io/providers/vmware/vcd/latest/docs/data-sources/nsxt_edgegateway)                 | Data Source  |
| [vcd_nsxt_alb_edgegateway_service_engine_group](https://registry.terraform.io/providers/vmware/vcd/latest/docs/data-sources/nsxt_alb_edgegateway_service_engine_group) | Data Source  |
| [vcd_nsxt_alb_pool](https://registry.terraform.io/providers/vmware/vcd/latest/docs/data-sources/nsxt_alb_pool)                       | Data Source  |
| [vcd_library_certificate](https://registry.terraform.io/providers/vmware/vcd/latest/docs/data-sources/library_certificate)             | Data Source  |
| [vcd_nsxt_alb_virtual_service](https://registry.terraform.io/providers/vmware/vcd/latest/docs/resources/nsxt_alb_virtual_service)     | Resource     |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| vdc_org_name | The name of the Data Center Group Organization in VCD | string | `"Organization Name Format: <Account_Number>-<Region>-<Account_Name>"` | yes |
| vdc_group_name | The name of the Data Center Group in VCD | string | `"Data Center Group Name Format: <Account_Number>-<Region>-<Account_Name> <datacenter group>"` | yes |
| vdc_edge_name | Name of the Data Center Group Edge Gateway | string | `"Edge Gateway Name Format: <Account_Number>-<Region>-<Edge_GW_Identifier>-<edge>"` | Yes |
| service_engine_group_name | The name of the NSX-T ALB Service Engine Group | string | `"Service Engine Group Name Format: <Region>-rsvc-lb-segroup<01>"` | yes |
| pool_name | The name of the NSX-T ALB Pool | string | - | yes |
| virtual_service_name | The name of the NSX-T ALB Virtual Service | string | - | yes |
| virtual_service_description | The description of the NSX-T ALB Virtual Service | string | "" | no |
| application_profile_type | The type of application profile for the NSX-T ALB Virtual Service | string | - | yes |
| is_transparent_mode_enabled | Whether the transparent mode is enabled for the NSX-T ALB Virtual Service | bool | false | no |
| cert_alias | The alias of the certificate from the VCD library | string | "" | no |
| ca_certificate_required | Defines if a CA certificate is required for the virtual service. Set to true for HTTPS and L4_TLS types, and to false for HTTP and L4 types. | bool | false | no |
| service_ports | List of service ports configuration for the NSX-T ALB Virtual Service | list(object({ start_port = number, end_port = optional(number), type = string, ssl_enabled = optional(bool) })) | - | yes |
| virtual_ip_address | IP Address for the service to listen on | string | - | yes |


## Outputs

| Name                                    | Description                                                    |
|-----------------------------------------|----------------------------------------------------------------|
| alb_virtual_service_id                  | ID of the created NSX-T ALB Virtual Service                    |
| alb_virtual_service_vip                 | IP Address of the created NSX-T ALB Virtual Service             |
| alb_pool_id                             | ID of the NSX-T ALB Pool                                        |
| alb_pool_name                           | Name of the NSX-T ALB Pool                                      |
| alb_application_profile_type            | Type of application profile for the NSX-T ALB Virtual Service   |
| alb_virtual_service_service_ports       | List of service ports configuration for the NSX-T ALB Virtual Service |

## Example Usage

```terraform
module "nsxt_alb_virtual_service" {
  source                        = "github.com/global-vmware/vcd_nsxt_alb_virtual_service.git?ref=v1.1.0"

  vdc_group_name                = "<US1-VDC-GRP-NAME>"
  vdc_org_name                  = "<US1-VDC-ORG-NAME>"
  vdc_edge_name                 = "<US1-VDC-EDGE-NAME>"
  service_engine_group_name     = "<US1-VDC-SEGROUP-NAME>"
  
  virtual_service_name          = "test-vip-01"

  pool_name                     = "test-pool-01"

  application_profile_type      = "HTTPS"

  ca_certificate_required       = true
  cert_alias                    = "US1-domain.com-SSL-Certificate"

  virtual_ip_address            = "204.232.237.200"

  service_ports = [
    {
        start_port  = 443,
        type        = "TCP_PROXY",
        ssl_enabled = true,
    },
    {
        start_port  = 8443,
        type        = "TCP_PROXY",
        ssl_enabled = true
    }
  ]
}
```

## Authors

This module is maintained by the [Global VMware Cloud Automation Services Team](https://github.com/global-vmware).
