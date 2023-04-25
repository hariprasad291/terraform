variable "region" {
  description = "Region to create infra"
  type        = string
  default     = ""
}

variable "create_vpc" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "cidr" {
  description = "(Optional) The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using `ipv4_netmask_length` & `ipv4_ipam_pool_id`"
  type        = string
  default     = "0.0.0.0/0"
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = false
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    "key" = "value"
  }
}

variable "vpc_tags" {
  description = "Additional tags for the VPC"
  type        = map(string)
  default = {
    "key" = "value"
  }
}

variable "secondary_cidr_blocks" {
  description = "List of secondary CIDR blocks to associate with the VPC to extend the IP Address pool"
  type        = list(string)
  default     = []
}

variable "manage_default_security_group" {
  description = "Should be true to adopt and manage default security group"
  type        = bool
  default     = false
}

variable "default_security_group_ingress" {
  description = "List of maps of ingress rules to set on the default security group"
  type        = list(map(string))
  default = [{
    "key" = "value"
  }]
}

variable "default_security_group_egress" {
  description = "List of maps of egress rules to set on the default security group"
  type        = list(map(string))
  default     = []
}

variable "default_security_group_name" {
  description = "Name to be used on the default security group"
  type        = string
  default     = null
}

variable "default_security_group_tags" {
  description = "Additional tags for the default security group"
  type        = map(string)
  default     = {}
}

variable "enable_dhcp_options" {
  description = "Should be true if you want to specify a DHCP options set with a custom domain name, DNS servers, NTP servers, netbios servers, and/or netbios server type"
  type        = bool
  default     = false
}

variable "dhcp_options_domain_name" {
  description = "Specifies DNS name for DHCP options set (requires enable_dhcp_options set to true)"
  type        = string
  default     = ""
}

variable "dhcp_options_domain_name_servers" {
  description = "Specify a list of DNS server addresses for DHCP options set, default to AWS provided (requires enable_dhcp_options set to true)"
  type        = list(string)
  default     = ["AmazonProvidedDNS"]
}

variable "dhcp_options_tags" {
  description = "Additional tags for the DHCP option set (requires enable_dhcp_options set to true)"
  type        = map(string)
  default     = {}
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = []
}

variable "igw_tags" {
  description = "Additional tags for the internet gateway"
  type        = map(string)
  default     = {}
}

variable "public_subnet_names" {
  description = "Explicit values to use in the Name tag on public subnets. If empty, Name tags are generated."
  type        = list(string)
  default     = []
}

variable "private_subnet_names" {
  description = "Explicit values to use in the Name tag on private subnets. If empty, Name tags are generated."
  type        = list(string)
  default     = []
}

variable "manage_default_route_table" {
  description = "Should be true to manage default route table"
  type        = bool
  default     = false
}

variable "default_route_table_routes" {
  description = "Configuration block of routes. See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table#route"
  type        = list(map(string))
  default     = []
}

variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = bool
  default     = false
}

variable "manage_default_network_acl" {
  description = "Should be true to adopt and manage Default Network ACL"
  type        = bool
  default     = false
}

variable "public_dedicated_network_acl" {
  description = "Whether to use dedicated network ACL (not default) and custom rules for public subnets"
  type        = bool
  default     = false
}

variable "default_network_acl_tags" {
  description = "Additional tags for the Default Network ACL"
  type        = map(string)
  default     = {}
}

variable "public_acl_tags" {
  description = "Additional tags for the public subnets network ACL"
  type        = map(string)
  default     = {}
}

variable "public_inbound_acl_rules" {
  description = "Public subnets inbound network ACLs"
  type        = list(map(string))
  default     = []
}

variable "public_outbound_acl_rules" {
  description = "Public subnets outbound network ACLs"
  type        = list(map(string))
  default     = []
}

variable "private_dedicated_network_acl" {
  description = "Whether to use dedicated network ACL (not default) and custom rules for private subnets"
  type        = bool
  default     = false
}

variable "private_acl_tags" {
  description = "Additional tags for the private subnets network ACL"
  type        = map(string)
  default     = {}
}

variable "private_inbound_acl_rules" {
  description = "Private subnets inbound network ACLs"
  type        = list(map(string))
  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}

variable "private_outbound_acl_rules" {
  description = "Private subnets outbound network ACLs"
  type        = list(map(string))
  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  type        = bool
  default     = false
}

variable "customer_gateways" {
  description = "Maps of Customer Gateway's attributes (BGP ASN and Gateway's Internet-routable external IP address)"
  type        = map(map(any))
  default = {
    "test" = {
      "bgp_asn"     = 65000
      "ip_address"  = "0.0.0.0"
      "device_name" = null
    }
  }
}

variable "eks-cluster" {
  type = object({
    name  = string
  })
  default = {
    name = "value"
  }
}

########################
# Flow log
########################

variable "enable_flow_log" {
  description = "Whether or not to enable VPC Flow Logs"
  type        = bool
  default     = true
}

variable "create_flow_log_cloudwatch_log_group" {
  description = "Whether to create CloudWatch log group for VPC Flow Logs"
  type        = bool
  default     = false
}

variable "create_flow_log_cloudwatch_iam_role" {
  description = "Whether to create IAM role for VPC Flow Logs"
  type        = bool
  default     = false
}

variable "secret_manager" {
  type = object({
    name  = string
  })
  default = {
    name = "test-1"
  }
}


################## Endpoints variables ################
variable "enable_endpoints" {
  description = "Determines whether resources will be created"
  type        = bool
  default     = true
}

variable "endpoints" {
  description = "A map of interface and/or gateway endpoints containing their properties and configurations"
  type        = map(map(any))
  default = {
    "test" = {
      "service" = "s3"
      "service_name" = null
      "service_type" = "Interface"
    }
  } 
}

variable "security_group_ids" {
  description = "Default security group IDs to associate with the VPC endpoints"
  type        = list(string)
  default     = []
}

variable "subnet_ids" {
  description = "Default subnets IDs to associate with the VPC endpoints"
  type        = list(string)
  default     = []
}

# variable "public_subnet_ipv6_prefixes" {
#   description = "Assigns IPv6 public subnet id based on the Amazon provided /56 prefix base 10 integer (0-256). Must be of equal length to the corresponding IPv4 subnet list"
#   type        = list(string)
#   default     = []
# }

# variable "outpost_subnet_ipv6_prefixes" {
#   description = "Assigns IPv6 outpost subnet id based on the Amazon provided /56 prefix base 10 integer (0-256). Must be of equal length to the corresponding IPv4 subnet list"
#   type        = list(string)
#   default     = []
# }

# variable "database_subnet_ipv6_prefixes" {
#   description = "Assigns IPv6 database subnet id based on the Amazon provided /56 prefix base 10 integer (0-256). Must be of equal length to the corresponding IPv4 subnet list"
#   type        = list(string)
#   default     = []
# }

# variable "redshift_subnet_ipv6_prefixes" {
#   description = "Assigns IPv6 redshift subnet id based on the Amazon provided /56 prefix base 10 integer (0-256). Must be of equal length to the corresponding IPv4 subnet list"
#   type        = list(string)
#   default     = []
# }

# variable "elasticache_subnet_ipv6_prefixes" {
#   description = "Assigns IPv6 elasticache subnet id based on the Amazon provided /56 prefix base 10 integer (0-256). Must be of equal length to the corresponding IPv4 subnet list"
#   type        = list(string)
#   default     = []
# }

# variable "intra_subnet_ipv6_prefixes" {
#   description = "Assigns IPv6 intra subnet id based on the Amazon provided /56 prefix base 10 integer (0-256). Must be of equal length to the corresponding IPv4 subnet list"
#   type        = list(string)
#   default     = []
# }

# variable "outpost_subnet_assign_ipv6_address_on_creation" {
#   description = "Assign IPv6 address on outpost subnet, must be disabled to change IPv6 CIDRs. This is the IPv6 equivalent of map_public_ip_on_launch"
#   type        = bool
#   default     = null
# }

# variable "database_subnet_assign_ipv6_address_on_creation" {
#   description = "Assign IPv6 address on database subnet, must be disabled to change IPv6 CIDRs. This is the IPv6 equivalent of map_public_ip_on_launch"
#   type        = bool
#   default     = null
# }

# variable "redshift_subnet_assign_ipv6_address_on_creation" {
#   description = "Assign IPv6 address on redshift subnet, must be disabled to change IPv6 CIDRs. This is the IPv6 equivalent of map_public_ip_on_launch"
#   type        = bool
#   default     = null
# }

# variable "elasticache_subnet_assign_ipv6_address_on_creation" {
#   description = "Assign IPv6 address on elasticache subnet, must be disabled to change IPv6 CIDRs. This is the IPv6 equivalent of map_public_ip_on_launch"
#   type        = bool
#   default     = null
# }

# variable "intra_subnet_assign_ipv6_address_on_creation" {
#   description = "Assign IPv6 address on intra subnet, must be disabled to change IPv6 CIDRs. This is the IPv6 equivalent of map_public_ip_on_launch"
#   type        = bool
#   default     = null
# }

# variable "instance_tenancy" {
#   description = "A tenancy option for instances launched into the VPC"
#   type        = string
#   default     = "default"
# }

# variable "public_subnet_suffix" {
#   description = "Suffix to append to public subnets name"
#   type        = string
#   default     = "public"
# }

# variable "private_subnet_suffix" {
#   description = "Suffix to append to private subnets name"
#   type        = string
#   default     = "private"
# }

# variable "outpost_subnet_names" {
#   description = "Explicit values to use in the Name tag on outpost subnets. If empty, Name tags are generated."
#   type        = list(string)
#   default     = []
# }

# variable "intra_subnet_names" {
#   description = "Explicit values to use in the Name tag on intra subnets. If empty, Name tags are generated."
#   type        = list(string)
#   default     = []
# }

# variable "database_subnet_names" {
#   description = "Explicit values to use in the Name tag on database subnets. If empty, Name tags are generated."
#   type        = list(string)
#   default     = []
# }

# variable "redshift_subnet_names" {
#   description = "Explicit values to use in the Name tag on redshift subnets. If empty, Name tags are generated."
#   type        = list(string)
#   default     = []
# }

# variable "elasticache_subnet_names" {
#   description = "Explicit values to use in the Name tag on elasticache subnets. If empty, Name tags are generated."
#   type        = list(string)
#   default     = []
# }

# variable "outpost_subnet_suffix" {
#   description = "Suffix to append to outpost subnets name"
#   type        = string
#   default     = "outpost"
# }

# variable "intra_subnet_suffix" {
#   description = "Suffix to append to intra subnets name"
#   type        = string
#   default     = "intra"
# }

# variable "database_subnet_suffix" {
#   description = "Suffix to append to database subnets name"
#   type        = string
#   default     = "db"
# }

# variable "redshift_subnet_suffix" {
#   description = "Suffix to append to redshift subnets name"
#   type        = string
#   default     = "redshift"
# }

# variable "elasticache_subnet_suffix" {
#   description = "Suffix to append to elasticache subnets name"
#   type        = string
#   default     = "elasticache"
# }

# variable "outpost_subnets" {
#   description = "A list of outpost subnets inside the VPC"
#   type        = list(string)
#   default     = []
# }

# variable "database_subnets" {
#   description = "A list of database subnets"
#   type        = list(string)
#   default     = []
# }

# variable "redshift_subnets" {
#   description = "A list of redshift subnets"
#   type        = list(string)
#   default     = []
# }

# variable "elasticache_subnets" {
#   description = "A list of elasticache subnets"
#   type        = list(string)
#   default     = []
# }

# variable "intra_subnets" {
#   description = "A list of intra subnets"
#   type        = list(string)
#   default     = []
# }

# variable "create_database_subnet_route_table" {
#   description = "Controls if separate route table for database should be created"
#   type        = bool
#   default     = false
# }

# variable "create_redshift_subnet_route_table" {
#   description = "Controls if separate route table for redshift should be created"
#   type        = bool
#   default     = false
# }

# variable "enable_public_redshift" {
#   description = "Controls if redshift should have public routing table"
#   type        = bool
#   default     = false
# }

# variable "create_elasticache_subnet_route_table" {
#   description = "Controls if separate route table for elasticache should be created"
#   type        = bool
#   default     = false
# }

# variable "create_database_subnet_group" {
#   description = "Controls if database subnet group should be created (n.b. database_subnets must also be set)"
#   type        = bool
#   default     = true
# }

# variable "create_elasticache_subnet_group" {
#   description = "Controls if elasticache subnet group should be created"
#   type        = bool
#   default     = true
# }

# variable "create_redshift_subnet_group" {
#   description = "Controls if redshift subnet group should be created"
#   type        = bool
#   default     = true
# }

# variable "create_database_internet_gateway_route" {
#   description = "Controls if an internet gateway route for public database access should be created"
#   type        = bool
#   default     = false
# }

# variable "create_database_nat_gateway_route" {
#   description = "Controls if a nat gateway route should be created to give internet access to the database subnets"
#   type        = bool
#   default     = false
# }

# # tflint-ignore: terraform_unused_declarations
# variable "enable_classiclink" {
#   description = "[DEPRECATED](https://github.com/hashicorp/terraform/issues/31730) Should be true to enable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic."
#   type        = bool
#   default     = null
# }

# # tflint-ignore: terraform_unused_declarations
# variable "enable_classiclink_dns_support" {
#   description = "[DEPRECATED](https://github.com/hashicorp/terraform/issues/31730) Should be true to enable ClassicLink DNS Support for the VPC. Only valid in regions and accounts that support EC2 Classic."
#   type        = bool
#   default     = null
# }

# variable "nat_gateway_destination_cidr_block" {
#   description = "Used to pass a custom destination route for private NAT Gateway. If not specified, the default 0.0.0.0/0 is used as a destination route."
#   type        = string
#   default     = "0.0.0.0/0"
# }

# variable "one_nat_gateway_per_az" {
#   description = "Should be true if you want only one NAT Gateway per availability zone. Requires `var.azs` to be set, and the number of `public_subnets` created to be greater than or equal to the number of availability zones specified in `var.azs`."
#   type        = bool
#   default     = false
# }

# variable "reuse_nat_ips" {
#   description = "Should be true if you don't want EIPs to be created for your NAT Gateways and will instead pass them in via the 'external_nat_ip_ids' variable"
#   type        = bool
#   default     = false
# }

# variable "external_nat_ip_ids" {
#   description = "List of EIP IDs to be assigned to the NAT Gateways (used in combination with reuse_nat_ips)"
#   type        = list(string)
#   default     = []
# }

# variable "external_nat_ips" {
#   description = "List of EIPs to be used for `nat_public_ips` output (used in combination with reuse_nat_ips and external_nat_ip_ids)"
#   type        = list(string)
#   default     = []
# }

# variable "map_public_ip_on_launch" {
#   description = "Should be false if you do not want to auto-assign public IP on launch"
#   type        = bool
#   default     = true
# }

# variable "enable_vpn_gateway" {
#   description = "Should be true if you want to create a new VPN Gateway resource and attach it to the VPC"
#   type        = bool
#   default     = false
# }

# variable "vpn_gateway_id" {
#   description = "ID of VPN Gateway to attach to the VPC"
#   type        = string
#   default     = ""
# }

# variable "amazon_side_asn" {
#   description = "The Autonomous System Number (ASN) for the Amazon side of the gateway. By default the virtual private gateway is created with the current default Amazon ASN."
#   type        = string
#   default     = "64512"
# }

# variable "vpn_gateway_az" {
#   description = "The Availability Zone for the VPN Gateway"
#   type        = string
#   default     = null
# }

# variable "propagate_intra_route_tables_vgw" {
#   description = "Should be true if you want route table propagation"
#   type        = bool
#   default     = false
# }

# variable "propagate_private_route_tables_vgw" {
#   description = "Should be true if you want route table propagation"
#   type        = bool
#   default     = false
# }

# variable "propagate_public_route_tables_vgw" {
#   description = "Should be true if you want route table propagation"
#   type        = bool
#   default     = false
# }

# variable "default_route_table_name" {
#   description = "Name to be used on the default route table"
#   type        = string
#   default     = null
# }

# variable "default_route_table_propagating_vgws" {
#   description = "List of virtual gateways for propagation"
#   type        = list(string)
#   default     = []
# }

# variable "public_subnet_tags" {
#   description = "Additional tags for the public subnets"
#   type        = map(string)
#   default     = {}
# }

# variable "public_subnet_tags_per_az" {
#   description = "Additional tags for the public subnets where the primary key is the AZ"
#   type        = map(map(string))
#   default     = {}
# }

# variable "private_subnet_tags" {
#   description = "Additional tags for the private subnets"
#   type        = map(string)
#   default     = {}
# }

# variable "private_subnet_tags_per_az" {
#   description = "Additional tags for the private subnets where the primary key is the AZ"
#   type        = map(map(string))
#   default     = {}
# }

# variable "outpost_subnet_tags" {
#   description = "Additional tags for the outpost subnets"
#   type        = map(string)
#   default     = {}
# }

# variable "public_route_table_tags" {
#   description = "Additional tags for the public route tables"
#   type        = map(string)
#   default     = {}
# }

# variable "private_route_table_tags" {
#   description = "Additional tags for the private route tables"
#   type        = map(string)
#   default     = {}
# }

# variable "database_route_table_tags" {
#   description = "Additional tags for the database route tables"
#   type        = map(string)
#   default     = {}
# }

# variable "redshift_route_table_tags" {
#   description = "Additional tags for the redshift route tables"
#   type        = map(string)
#   default     = {}
# }

# variable "elasticache_route_table_tags" {
#   description = "Additional tags for the elasticache route tables"
#   type        = map(string)
#   default     = {}
# }

# variable "intra_route_table_tags" {
#   description = "Additional tags for the intra route tables"
#   type        = map(string)
#   default     = {}
# }

# variable "database_subnet_group_name" {
#   description = "Name of database subnet group"
#   type        = string
#   default     = null
# }

# variable "database_subnet_tags" {
#   description = "Additional tags for the database subnets"
#   type        = map(string)
#   default     = {}
# }

# variable "database_subnet_group_tags" {
#   description = "Additional tags for the database subnet group"
#   type        = map(string)
#   default     = {}
# }

# variable "redshift_subnet_tags" {
#   description = "Additional tags for the redshift subnets"
#   type        = map(string)
#   default     = {}
# }

# variable "redshift_subnet_group_name" {
#   description = "Name of redshift subnet group"
#   type        = string
#   default     = null
# }

# variable "redshift_subnet_group_tags" {
#   description = "Additional tags for the redshift subnet group"
#   type        = map(string)
#   default     = {}
# }

# variable "elasticache_subnet_group_name" {
#   description = "Name of elasticache subnet group"
#   type        = string
#   default     = null
# }

# variable "elasticache_subnet_group_tags" {
#   description = "Additional tags for the elasticache subnet group"
#   type        = map(string)
#   default     = {}
# }

# variable "elasticache_subnet_tags" {
#   description = "Additional tags for the elasticache subnets"
#   type        = map(string)
#   default     = {}
# }

# variable "intra_subnet_tags" {
#   description = "Additional tags for the intra subnets"
#   type        = map(string)
#   default     = {}
# }

# variable "outpost_acl_tags" {
#   description = "Additional tags for the outpost subnets network ACL"
#   type        = map(string)
#   default     = {}
# }

# variable "intra_acl_tags" {
#   description = "Additional tags for the intra subnets network ACL"
#   type        = map(string)
#   default     = {}
# }

# variable "database_acl_tags" {
#   description = "Additional tags for the database subnets network ACL"
#   type        = map(string)
#   default     = {}
# }

# variable "redshift_acl_tags" {
#   description = "Additional tags for the redshift subnets network ACL"
#   type        = map(string)
#   default     = {}
# }

# variable "elasticache_acl_tags" {
#   description = "Additional tags for the elasticache subnets network ACL"
#   type        = map(string)
#   default     = {}
# }

# variable "nat_gateway_tags" {
#   description = "Additional tags for the NAT gateways"
#   type        = map(string)
#   default     = {}
# }

# variable "nat_eip_tags" {
#   description = "Additional tags for the NAT EIP"
#   type        = map(string)
#   default     = {}
# }

# variable "customer_gateway_tags" {
#   description = "Additional tags for the Customer Gateway"
#   type        = map(string)
#   default     = {}
# }

# variable "vpn_gateway_tags" {
#   description = "Additional tags for the VPN gateway"
#   type        = map(string)
#   default     = {}
# }

# variable "vpc_flow_log_tags" {
#   description = "Additional tags for the VPC Flow Logs"
#   type        = map(string)
#   default     = {}
# }

# variable "vpc_flow_log_permissions_boundary" {
#   description = "The ARN of the Permissions Boundary for the VPC Flow Log IAM Role"
#   type        = string
#   default     = null
# }

# variable "dhcp_options_ntp_servers" {
#   description = "Specify a list of NTP servers for DHCP options set (requires enable_dhcp_options set to true)"
#   type        = list(string)
#   default     = []
# }

# variable "dhcp_options_netbios_name_servers" {
#   description = "Specify a list of netbios servers for DHCP options set (requires enable_dhcp_options set to true)"
#   type        = list(string)
#   default     = []
# }

# variable "dhcp_options_netbios_node_type" {
#   description = "Specify netbios node_type for DHCP options set (requires enable_dhcp_options set to true)"
#   type        = string
#   default     = ""
# }

# variable "manage_default_vpc" {
#   description = "Should be true to adopt and manage Default VPC"
#   type        = bool
#   default     = false
# }

# variable "default_vpc_name" {
#   description = "Name to be used on the Default VPC"
#   type        = string
#   default     = null
# }

# variable "default_vpc_enable_dns_support" {
#   description = "Should be true to enable DNS support in the Default VPC"
#   type        = bool
#   default     = true
# }

# variable "default_vpc_enable_dns_hostnames" {
#   description = "Should be true to enable DNS hostnames in the Default VPC"
#   type        = bool
#   default     = false
# }

# # tflint-ignore: terraform_unused_declarations
# variable "default_vpc_enable_classiclink" {
#   description = "[DEPRECATED](https://github.com/hashicorp/terraform/issues/31730) Should be true to enable ClassicLink in the Default VPC"
#   type        = bool
#   default     = false
# }

# variable "default_vpc_tags" {
#   description = "Additional tags for the Default VPC"
#   type        = map(string)
#   default     = {}
# }

# variable "default_network_acl_name" {
#   description = "Name to be used on the Default Network ACL"
#   type        = string
#   default     = null
# }

# variable "outpost_dedicated_network_acl" {
#   description = "Whether to use dedicated network ACL (not default) and custom rules for outpost subnets"
#   type        = bool
#   default     = false
# }

# variable "intra_dedicated_network_acl" {
#   description = "Whether to use dedicated network ACL (not default) and custom rules for intra subnets"
#   type        = bool
#   default     = false
# }

# variable "database_dedicated_network_acl" {
#   description = "Whether to use dedicated network ACL (not default) and custom rules for database subnets"
#   type        = bool
#   default     = false
# }

# variable "redshift_dedicated_network_acl" {
#   description = "Whether to use dedicated network ACL (not default) and custom rules for redshift subnets"
#   type        = bool
#   default     = false
# }

# variable "elasticache_dedicated_network_acl" {
#   description = "Whether to use dedicated network ACL (not default) and custom rules for elasticache subnets"
#   type        = bool
#   default     = false
# }

# variable "default_network_acl_ingress" {
#   description = "List of maps of ingress rules to set on the Default Network ACL"
#   type        = list(map(string))

#   default = [
#     {
#       rule_no    = 100
#       action     = "allow"
#       from_port  = 0
#       to_port    = 0
#       protocol   = "-1"
#       cidr_block = "0.0.0.0/0"
#     },
#     {
#       rule_no         = 101
#       action          = "allow"
#       from_port       = 0
#       to_port         = 0
#       protocol        = "-1"
#       ipv6_cidr_block = "::/0"
#     },
#   ]
# }

# variable "default_network_acl_egress" {
#   description = "List of maps of egress rules to set on the Default Network ACL"
#   type        = list(map(string))

#   default = [
#     {
#       rule_no    = 100
#       action     = "allow"
#       from_port  = 0
#       to_port    = 0
#       protocol   = "-1"
#       cidr_block = "0.0.0.0/0"
#     },
#     {
#       rule_no         = 101
#       action          = "allow"
#       from_port       = 0
#       to_port         = 0
#       protocol        = "-1"
#       ipv6_cidr_block = "::/0"
#     },
#   ]
# }

# variable "outpost_inbound_acl_rules" {
#   description = "Outpost subnets inbound network ACLs"
#   type        = list(map(string))

#   default = [
#     {
#       rule_number = 100
#       rule_action = "allow"
#       from_port   = 0
#       to_port     = 0
#       protocol    = "-1"
#       cidr_block  = "0.0.0.0/0"
#     },
#   ]
# }

# variable "outpost_outbound_acl_rules" {
#   description = "Outpost subnets outbound network ACLs"
#   type        = list(map(string))

#   default = [
#     {
#       rule_number = 100
#       rule_action = "allow"
#       from_port   = 0
#       to_port     = 0
#       protocol    = "-1"
#       cidr_block  = "0.0.0.0/0"
#     },
#   ]
# }

# variable "intra_inbound_acl_rules" {
#   description = "Intra subnets inbound network ACLs"
#   type        = list(map(string))

#   default = [
#     {
#       rule_number = 100
#       rule_action = "allow"
#       from_port   = 0
#       to_port     = 0
#       protocol    = "-1"
#       cidr_block  = "0.0.0.0/0"
#     },
#   ]
# }

# variable "intra_outbound_acl_rules" {
#   description = "Intra subnets outbound network ACLs"
#   type        = list(map(string))

#   default = [
#     {
#       rule_number = 100
#       rule_action = "allow"
#       from_port   = 0
#       to_port     = 0
#       protocol    = "-1"
#       cidr_block  = "0.0.0.0/0"
#     },
#   ]
# }

# variable "database_inbound_acl_rules" {
#   description = "Database subnets inbound network ACL rules"
#   type        = list(map(string))

#   default = [
#     {
#       rule_number = 100
#       rule_action = "allow"
#       from_port   = 0
#       to_port     = 0
#       protocol    = "-1"
#       cidr_block  = "0.0.0.0/0"
#     },
#   ]
# }

# variable "database_outbound_acl_rules" {
#   description = "Database subnets outbound network ACL rules"
#   type        = list(map(string))

#   default = [
#     {
#       rule_number = 100
#       rule_action = "allow"
#       from_port   = 0
#       to_port     = 0
#       protocol    = "-1"
#       cidr_block  = "0.0.0.0/0"
#     },
#   ]
# }

# variable "redshift_inbound_acl_rules" {
#   description = "Redshift subnets inbound network ACL rules"
#   type        = list(map(string))

#   default = [
#     {
#       rule_number = 100
#       rule_action = "allow"
#       from_port   = 0
#       to_port     = 0
#       protocol    = "-1"
#       cidr_block  = "0.0.0.0/0"
#     },
#   ]
# }

# variable "redshift_outbound_acl_rules" {
#   description = "Redshift subnets outbound network ACL rules"
#   type        = list(map(string))

#   default = [
#     {
#       rule_number = 100
#       rule_action = "allow"
#       from_port   = 0
#       to_port     = 0
#       protocol    = "-1"
#       cidr_block  = "0.0.0.0/0"
#     },
#   ]
# }

# variable "elasticache_inbound_acl_rules" {
#   description = "Elasticache subnets inbound network ACL rules"
#   type        = list(map(string))

#   default = [
#     {
#       rule_number = 100
#       rule_action = "allow"
#       from_port   = 0
#       to_port     = 0
#       protocol    = "-1"
#       cidr_block  = "0.0.0.0/0"
#     },
#   ]
# }

# variable "elasticache_outbound_acl_rules" {
#   description = "Elasticache subnets outbound network ACL rules"
#   type        = list(map(string))

#   default = [
#     {
#       rule_number = 100
#       rule_action = "allow"
#       from_port   = 0
#       to_port     = 0
#       protocol    = "-1"
#       cidr_block  = "0.0.0.0/0"
#     },
#   ]
# }

# variable "flow_log_traffic_type" {
#   description = "The type of traffic to capture. Valid values: ACCEPT, REJECT, ALL."
#   type        = string
#   default     = "ALL"
# }

# variable "flow_log_destination_type" {
#   description = "Type of flow log destination. Can be s3 or cloud-watch-logs."
#   type        = string
#   default     = "cloud-watch-logs"
# }

# variable "flow_log_log_format" {
#   description = "The fields to include in the flow log record, in the order in which they should appear."
#   type        = string
#   default     = null
# }

# variable "flow_log_destination_arn" {
#   description = "The ARN of the CloudWatch log group or S3 bucket where VPC Flow Logs will be pushed. If this ARN is a S3 bucket the appropriate permissions need to be set on that bucket's policy. When create_flow_log_cloudwatch_log_group is set to false this argument must be provided."
#   type        = string
#   default     = ""
# }

# variable "flow_log_cloudwatch_iam_role_arn" {
#   description = "The ARN for the IAM role that's used to post flow logs to a CloudWatch Logs log group. When flow_log_destination_arn is set to ARN of Cloudwatch Logs, this argument needs to be provided."
#   type        = string
#   default     = ""
# }

# variable "flow_log_cloudwatch_log_group_name_prefix" {
#   description = "Specifies the name prefix of CloudWatch Log Group for VPC flow logs."
#   type        = string
#   default     = "/aws/vpc-flow-log/"
# }

# variable "flow_log_cloudwatch_log_group_name_suffix" {
#   description = "Specifies the name suffix of CloudWatch Log Group for VPC flow logs."
#   type        = string
#   default     = ""
# }

# variable "flow_log_cloudwatch_log_group_retention_in_days" {
#   description = "Specifies the number of days you want to retain log events in the specified log group for VPC flow logs."
#   type        = number
#   default     = null
# }

# variable "flow_log_cloudwatch_log_group_kms_key_id" {
#   description = "The ARN of the KMS Key to use when encrypting log data for VPC flow logs."
#   type        = string
#   default     = null
# }

# variable "flow_log_max_aggregation_interval" {
#   description = "The maximum interval of time during which a flow of packets is captured and aggregated into a flow log record. Valid Values: `60` seconds or `600` seconds."
#   type        = number
#   default     = 600
# }

# variable "create_igw" {
#   description = "Controls if an Internet Gateway is created for public subnets and the related routes that connect them."
#   type        = bool
#   default     = true
# }

# variable "create_egress_only_igw" {
#   description = "Controls if an Egress Only Internet Gateway is created and its related routes."
#   type        = bool
#   default     = true
# }

# variable "outpost_arn" {
#   description = "ARN of Outpost you want to create a subnet in."
#   type        = string
#   default     = null
# }

# variable "outpost_az" {
#   description = "AZ where Outpost is anchored."
#   type        = string
#   default     = null
# }

# variable "flow_log_file_format" {
#   description = "(Optional) The format for the flow log. Valid values: `plain-text`, `parquet`."
#   type        = string
#   default     = "plain-text"
#   validation {
#     condition = can(regex("^(plain-text|parquet)$",
#     var.flow_log_file_format))
#     error_message = "ERROR valid values: plain-text, parquet."
#   }
# }

# variable "flow_log_hive_compatible_partitions" {
#   description = "(Optional) Indicates whether to use Hive-compatible prefixes for flow logs stored in Amazon S3."
#   type        = bool
#   default     = false
# }

# variable "flow_log_per_hour_partition" {
#   description = "(Optional) Indicates whether to partition the flow log per hour. This reduces the cost and response time for queries."
#   type        = bool
#   default     = false
# }

# variable "use_ipam_pool" {
#   description = "Determines whether IPAM pool is used for CIDR allocation"
#   type        = bool
#   default     = false
# }

# variable "ipv4_ipam_pool_id" {
#   description = "(Optional) The ID of an IPv4 IPAM pool you want to use for allocating this VPC's CIDR."
#   type        = string
#   default     = null
# }

# variable "ipv4_netmask_length" {
#   description = "(Optional) The netmask length of the IPv4 CIDR you want to allocate to this VPC. Requires specifying a ipv4_ipam_pool_id."
#   type        = number
#   default     = null
# }

# variable "ipv6_cidr" {
#   description = "(Optional) IPv6 CIDR block to request from an IPAM Pool. Can be set explicitly or derived from IPAM using `ipv6_netmask_length`."
#   type        = string
#   default     = null
# }

# variable "ipv6_ipam_pool_id" {
#   description = "(Optional) IPAM Pool ID for a IPv6 pool. Conflicts with `assign_generated_ipv6_cidr_block`."
#   type        = string
#   default     = null
# }

# variable "ipv6_netmask_length" {
#   description = "(Optional) Netmask length to request from IPAM Pool. Conflicts with `ipv6_cidr_block`. This can be omitted if IPAM pool as a `allocation_default_netmask_length` set. Valid values: `56`."
#   type        = number
#   default     = null
# }

variable "timeouts" {
  description = "Define maximum timeout for creating, updating, and deleting VPC endpoint resources"
  type        = map(string)
  default = {
    "create" = "5m"
    "update" = "10m"
    "delete" = "5m"
  }
}

################################################################################
# Transit Gateway
################################################################################

variable "create_tgw" {
  description = "Controls if TGW should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "amazon_side_asn" {
  description = "The Autonomous System Number (ASN) for the Amazon side of the gateway. By default the TGW is created with the current default Amazon ASN."
  type        = string
  default     = null
}

variable "transit_gateway_cidr_blocks" {
  description = "One or more IPv4 or IPv6 CIDR blocks for the transit gateway. Must be a size /24 CIDR block or larger for IPv4, or a size /64 CIDR block or larger for IPv6"
  type        = list(string)
  default     = []
}

# variable "enable_default_route_table_propagation" {
#   description = "Whether resource attachments automatically propagate routes to the default propagation route table"
#   type        = bool
#   default     = true
# }

# variable "enable_auto_accept_shared_attachments" {
#   description = "Whether resource attachment requests are automatically accepted"
#   type        = bool
#   default     = false
# }

# variable "enable_vpn_ecmp_support" {
#   description = "Whether VPN Equal Cost Multipath Protocol support is enabled"
#   type        = bool
#   default     = true
# }

# variable "enable_mutlicast_support" {
#   description = "Whether multicast support is enabled"
#   type        = bool
#   default     = false
# }

# variable "tgw_tags" {
#   description = "Additional tags for the TGW"
#   type        = map(string)
#   default     = {}
# }

# variable "tgw_default_route_table_tags" {
#   description = "Additional tags for the Default TGW route table"
#   type        = map(string)
#   default     = {}
# }

# ################################################################################
# # VPC Attachment
# ################################################################################

variable "vpc_attachments" {
  description = "Maps of maps of VPC details to attach to TGW. Type 'any' to disable type validation by Terraform."
  type        = any
  default = {
    dns_support  = true
    ipv6_support = false

    transit_gateway_default_route_table_association = true
    transit_gateway_default_route_table_propagation = true

    tgw_routes = [
      {
        destination_cidr_block = "127.0.0.1 /0"
      },
      {
        blackhole              = true
        destination_cidr_block = "0.0.0.0/0"
      }
    ]
  }
}

# variable "tgw_vpc_attachment_tags" {
#   description = "Additional tags for VPC attachments"
#   type        = map(string)
#   default     = {}
# }

# ################################################################################
# # Route Table / Routes
# ################################################################################

# variable "transit_gateway_route_table_id" {
#   description = "Identifier of EC2 Transit Gateway Route Table to use with the Target Gateway when reusing it between multiple TGWs"
#   type        = string
#   default     = null
# }

# variable "tgw_route_table_tags" {
#   description = "Additional tags for the TGW route table"
#   type        = map(string)
#   default     = {}
# }

# ################################################################################
# # Resource Access Manager
# ################################################################################

# variable "share_tgw" {
#   description = "Whether to share your transit gateway with other accounts"
#   type        = bool
#   default     = true
# }

# variable "ram_name" {
#   description = "The name of the resource share of TGW"
#   type        = string
#   default     = ""
# }

# variable "ram_allow_external_principals" {
#   description = "Indicates whether principals outside your organization can be associated with a resource share."
#   type        = bool
#   default     = false
# }

# variable "ram_principals" {
#   description = "A list of principals to share TGW with. Possible values are an AWS account ID, an AWS Organizations Organization ARN, or an AWS Organizations Organization Unit ARN"
#   type        = list(string)
#   default     = []
# }

# variable "ram_resource_share_arn" {
#   description = "ARN of RAM resource share"
#   type        = string
#   default     = ""
# }

# variable "ram_tags" {
#   description = "Additional tags for the RAM"
#   type        = map(string)
#   default     = {}
# }

################################################################################
# SQS Variables
################################################################################
variable "create" {
  description = "Whether to create SQS queue"
  type        = bool
  default     = true
}

################################################################################
# Queue
################################################################################

variable "content_based_deduplication" {
  description = "Enables content-based deduplication for FIFO queues"
  type        = bool
  default     = null
}

variable "deduplication_scope" {
  description = "Specifies whether message deduplication occurs at the message group or queue level"
  type        = string
  default     = null
}

variable "delay_seconds" {
  description = "The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900 (15 minutes)"
  type        = number
  default     = null
}

variable "fifo_queue" {
  description = "Boolean designating a FIFO queue"
  type        = bool
  default     = false
}

variable "fifo_throughput_limit" {
  description = "Specifies whether the FIFO queue throughput quota applies to the entire queue or per message group"
  type        = string
  default     = null
}

variable "kms_data_key_reuse_period_seconds" {
  description = "The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again. An integer representing seconds, between 60 seconds (1 minute) and 86,400 seconds (24 hours)"
  type        = number
  default     = null
}

variable "kms_master_key_id" {
  description = "The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK"
  type        = string
  default     = null
}

variable "max_message_size" {
  description = "The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB)"
  type        = number
  default     = null
}

variable "message_retention_seconds" {
  description = "The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days)"
  type        = number
  default     = null
}

variable "sqs_name" {
  description = "This is the human-readable name of the queue. If omitted, Terraform will assign a random name"
  type        = string
  default     = null
}

variable "use_name_prefix" {
  description = "Determines whether `name` is used as a prefix"
  type        = bool
  default     = false
}

variable "receive_wait_time_seconds" {
  description = "The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds)"
  type        = number
  default     = null
}

variable "redrive_allow_policy" {
  description = "The JSON policy to set up the Dead Letter Queue redrive permission, see AWS docs."
  type        = any
  default     = {}
}

variable "redrive_policy" {
  description = "The JSON policy to set up the Dead Letter Queue, see AWS docs. Note: when specifying maxReceiveCount, you must specify it as an integer (5), and not a string (\"5\")"
  type        = any
  default     = {}
}

variable "sqs_managed_sse_enabled" {
  description = "Boolean to enable server-side encryption (SSE) of message content with SQS-owned encryption keys"
  type        = bool
  default     = true
}

variable "visibility_timeout_seconds" {
  description = "The visibility timeout for the queue. An integer from 0 to 43200 (12 hours)"
  type        = number
  default     = null
}

variable "sqs_tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

################################################################################
# Queue Policy
################################################################################

variable "create_queue_policy" {
  description = "Whether to create SQS queue policy"
  type        = bool
  default     = false
}

variable "source_queue_policy_documents" {
  description = "List of IAM policy documents that are merged together into the exported document. Statements must have unique `sid`s"
  type        = list(string)
  default     = []
}

variable "override_queue_policy_documents" {
  description = "List of IAM policy documents that are merged together into the exported document. In merging, statements with non-blank `sid`s will override statements with the same `sid`"
  type        = list(string)
  default     = []
}

variable "queue_policy_statements" {
  description = "A map of IAM policy [statements](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document#statement) for custom permission usage"
  type = map(object({
    sid = string
    actions       = list(string)
    not_actions   = list(string)
    effect        = string
    resources     = list(string)
    not_resources = list(string)
    principals = map(object({
      type = string
      identifiers    = list(string)
    }))
    not_principals = map(object({
      type = string
      identifiers    = list(string)
    }))
    conditions = map(object({
      test = string
      values    = list(string)
      variable  = string
    }))
  }))
  default = {}
}

################################### Api Gateway #########################################
variable "create_api_gateway" {
  description = "Whether to create API Gateway"
  type        = bool
  default     = true
}

variable "protocol_type" {
  description = "The API protocol. Valid values: HTTP, WEBSOCKET"
  type        = string
  default     = "HTTP"
}

# routes and integrations
variable "integrations" {
  description = "Map of API gateway routes with integrations"
  type        = map(any)
  default = {
    "test" = {
      "data_trace_enabled"                  = false
      "logging_level"                       = null
      "throttling_burst_limit"              = null
      "throttling_rate_limit"               = null
      "api_key_required"                    = null
      "authorization_scopes"                = null
      "authorizer_id"                       = null
      "model_selection_expression"          = null
      "operation_name"                      = null
      "route_response_selection_expression" = null
      "integration_uri"                     = null
      "connection_type"                     = "VPC_LINK"      
    }
  }
}

variable "create_api_domain_name" {
  description = "Whether to create API domain name resource"
  type        = bool
  default     = false
}

variable "create_default_stage" {
  description = "Whether to create default stage"
  type        = bool
  default     = true
}

variable "default_stage_access_log_destination_arn" {
  description = "Default stage's ARN of the CloudWatch Logs log group to receive access logs. Any trailing :* is trimmed from the ARN."
  type        = string
  default     = null
}

variable "default_stage_access_log_format" {
  description = "Default stage's single line format of the access logs of data, as specified by selected $context variables."
  type        = string
  default     = null
}

variable "default_route_settings" {
  description = "Settings for default route"
  type        = map(string)
  default = {
    "data_trace_enabled"       = null
    "logging_level"            = null
    "detailed_metrics_enabled" = false
    "throttling_burst_limit"   = null
    "throttling_rate_limit"    = null
  }
}

variable "create_routes_and_integrations" {
  description = "Whether to create routes and integrations resources"
  type        = bool
  default     = false
}

variable "create_vpc_link" {
  description = "Whether to create VPC links"
  type        = bool
  default     = true
}