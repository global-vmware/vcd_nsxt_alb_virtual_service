variable "vdc_org_name" {}

variable "vdc_group_name" {}

variable "vdc_edge_name" {}

variable "service_engine_group_name" {
  description = "The name of the NSX-T ALB Service Engine Group"
  type        = string
}

variable "pool_name" {
  description = "The name of the NSX-T ALB Pool"
  type        = string
}

variable "virtual_service_name" {
  description = "The name of the NSX-T ALB Virtual Service"
  type        = string
}

variable "virtual_service_description" {
  description = "The description of the NSX-T ALB Virtual Service"
  type        = string
  default     = ""
}

variable "application_profile_type" {
  description = "The type of application profile for the NSX-T ALB Virtual Service"
  type        = string
}

variable "is_transparent_mode_enabled" {
  description = "Whether the transparent mode is enabled for the NSX-T ALB Virtual Service"
  type        = bool
  default     = false
}

variable "cert_alias" {
  description = "The alias of the certificate from the VCD library"
  type        = string
  default     = ""
}

variable "ca_certificate_required" {
  description = "Defines if a CA certificate is required for the virtual service. Set to true for HTTPS and L4_TLS types, and to false for HTTP and L4 types."
  type        = bool
}

variable "service_ports" {
  description = "List of service ports configuration for the NSX-T ALB Virtual Service"
  type        = list(object({
    start_port  = number
    end_port    = optional(number)
    type        = string
    ssl_enabled = optional(bool)
  }))
}

variable "virtual_ip_address" {
  description = "IP Address for the service to listen on"
  type        = string
}
