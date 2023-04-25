provider "aws" {
  region = local.region
}

locals {
  name   = "test-${replace(basename(path.cwd), "_", "-")}"
  region = var.region
  azs    = ["${local.region}a", "${local.region}b", "${local.region}c"]
}

module "network" {
  source                           = "./modules/network"
  create_vpc                       = var.create_vpc
  name                             = var.name
  cidr                             = var.cidr
  secondary_cidr_blocks            = var.secondary_cidr_blocks
  manage_default_security_group    = var.manage_default_security_group
  default_security_group_ingress   = var.default_security_group_ingress
  default_security_group_egress    = var.default_security_group_egress
  default_security_group_name      = var.default_security_group_name
  default_security_group_tags      = var.default_security_group_tags
  enable_dhcp_options              = var.enable_dhcp_options
  dhcp_options_domain_name         = var.dhcp_options_domain_name
  dhcp_options_domain_name_servers = var.dhcp_options_domain_name_servers
  dhcp_options_tags                = var.dhcp_options_tags

  azs                  = local.azs
  private_subnets      = var.private_subnets
  public_subnets       = var.public_subnets
  public_subnet_names  = var.public_subnet_names
  private_subnet_names = var.private_subnet_names

  manage_default_network_acl   = var.manage_default_network_acl
  default_network_acl_tags     = { Name = "${var.name}-default" }
  public_dedicated_network_acl = var.public_dedicated_network_acl
  public_inbound_acl_rules     = var.public_inbound_acl_rules
  public_outbound_acl_rules    = var.public_outbound_acl_rules
  public_acl_tags              = { Name = "${var.name}-public" }
  default_route_table_routes   = var.default_route_table_routes
  manage_default_route_table   = var.manage_default_route_table
  default_route_table_tags     = { Name = "${var.name}-default" }

  private_dedicated_network_acl = var.private_dedicated_network_acl
  private_acl_tags              = { Name = "${var.name}-private" }
  private_inbound_acl_rules     = var.private_inbound_acl_rules
  private_outbound_acl_rules    = var.private_outbound_acl_rules

  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  enable_nat_gateway = var.enable_nat_gateway



  single_nat_gateway = var.single_nat_gateway
  customer_gateways  = var.customer_gateways

  # enable_vpn_gateway = true
  # # VPC Flow Logs (Cloudwatch log group and IAM role will be created)
  enable_flow_log                      = var.enable_flow_log
  create_flow_log_cloudwatch_log_group = var.create_flow_log_cloudwatch_log_group
  create_flow_log_cloudwatch_iam_role  = var.create_flow_log_cloudwatch_iam_role

  tags     = var.tags
  vpc_tags = var.vpc_tags
  igw_tags = var.igw_tags
  timeouts = var.timeouts

  ## Tranit Gateway 
  create_tgw                  = var.create_tgw
  amazon_side_asn             = var.amazon_side_asn
  transit_gateway_cidr_blocks = var.transit_gateway_cidr_blocks
  vpc_attachments = {
    vpc1 = {
      vpc_id       = module.network.vpc_id == true ? module.network.vpc_id : "vpc-0e45f5fcaedba3280"
      subnet_ids   = module.network.private_subnets == true ? module.network.private_subnets : ["subnet-0789ba9a937884be9", "subnet-019964c0f9cecf1a0"] 
      dns_support  = try(var.vpc_attachments.dns_support, false)
      ipv6_support = try(var.vpc_attachments.ipv6_support, false)

      transit_gateway_default_route_table_association = try(var.vpc_attachments.transit_gateway_default_route_table_association, true)
      transit_gateway_default_route_table_propagation = try(var.vpc_attachments.transit_gateway_default_route_table_propagation, true)

      tgw_routes = [
        {
          destination_cidr_block = try(var.vpc_attachments.destination_cidr_block, "")
        },
        {
          blackhole              = try(var.vpc_attachments.blackhole, true)
          destination_cidr_block = try(var.vpc_attachments.destination_cidr_block, "")
        }
      ]
    }
  }
}

locals {
  domain_name = null #"terraform-aws-modules.modules.tf" # trimsuffix(data.aws_route53_zone.this.name, ".")
  subdomain   = null #"complete-http"
}

module "install" {  
  source = "./modules/install"
  create                            = var.create
  name                              = var.sqs_name
  content_based_deduplication       = var.content_based_deduplication
  deduplication_scope               = var.deduplication_scope
  delay_seconds                     = var.delay_seconds
  fifo_queue                        = var.fifo_queue
  fifo_throughput_limit             = var.fifo_throughput_limit
  kms_data_key_reuse_period_seconds = var.kms_data_key_reuse_period_seconds
  kms_master_key_id                 = var.kms_master_key_id
  max_message_size                  = var.max_message_size
  message_retention_seconds         = var.message_retention_seconds
  use_name_prefix                   = var.use_name_prefix
  receive_wait_time_seconds         = var.receive_wait_time_seconds
  redrive_allow_policy              = var.redrive_allow_policy
  redrive_policy                    = var.redrive_policy
  sqs_managed_sse_enabled           = var.sqs_managed_sse_enabled
  visibility_timeout_seconds        = var.visibility_timeout_seconds
  tags = var.sqs_tags

  ## queue policy variables.
  create_queue_policy             = var.create_queue_policy
  source_queue_policy_documents   = var.source_queue_policy_documents
  override_queue_policy_documents = var.override_queue_policy_documents
  queue_policy_statements = var.queue_policy_statements  

  ## Api Gateway variables.
  create_api_gateway  = var.create_api_gateway
  protocol_type       = var.protocol_type
  domain_name         = local.domain_name
  integrations        = var.integrations
  create_api_domain_name   = var.create_api_domain_name
  create_default_stage     = var.create_default_stage
  default_stage_access_log_destination_arn    = var.default_stage_access_log_destination_arn
  default_stage_access_log_format             = var.default_stage_access_log_format
  default_route_settings   =  var.default_route_settings
  create_routes_and_integrations  = var.create_routes_and_integrations
  create_vpc_link       = var.create_vpc_link
}