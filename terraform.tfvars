region = "us-east-1"

############################# VPC #############################
create_vpc           = true
name                 = "poc"
cidr                 = "10.0.0.0/16"
enable_dns_hostnames = true
enable_dns_support   = true

tags = {
  "AppID"             = "123"
  "Environment"       = "dev"
  "BU"                = "software"
  "MaintananceWindow" = "maintain"
  "Owner"             = "hari"
}

vpc_tags = {
  "vpc_name" = "spg-vpc"
}

secondary_cidr_blocks         = ["100.0.0.0/16"]
manage_default_security_group = true
default_security_group_ingress = [{
  self             = true
  cidr_blocks      = "0.0.0.0/0"
  ipv6_cidr_blocks = ""
  prefix_list_ids  = ""
  security_groups  = ""
  description      = null
  from_port        = 22
  to_port          = 22
  protocol         = "TCP"

}]

default_security_group_egress = [{
  self             = true
  cidr_blocks      = "0.0.0.0/0"
  ipv6_cidr_blocks = ""
  prefix_list_ids  = ""
  security_groups  = ""
  description      = null
  from_port        = 0
  to_port          = 0
  protocol         = "-1"
}]

default_security_group_name = "default-sg123"
default_security_group_tags = {
  "sg_name" = "default-sg-spg"
}

enable_dhcp_options              = true
dhcp_options_domain_name         = "aws.terrafomr"
dhcp_options_domain_name_servers = ["127.0.0.1", "10.10.0.2"]
dhcp_options_tags = {
  "name" = "dhcp-spg"
}
public_subnets = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
#azs = ["us-east-1a", "us-east-1b", "us-east-1c"]
igw_tags = {
  "name" = "igw-spg"
}

private_subnets            = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
public_subnet_names        = ["pub-sub1", "pub-sub2", "pub-sub3"]
private_subnet_names       = ["pri-sub1", "pri-sub2", "pri-sub3"]
manage_default_route_table = true
default_route_table_routes = [{
  cidr_block                = "0.0.0.0/0"
  ipv6_cidr_block           = null
  egress_only_gateway_id    = null
  gateway_id                = "igw-05852b7a6003ad826"
  instance_id               = null
  nat_gateway_id            = null
  network_interface_id      = null
  transit_gateway_id        = null
  vpc_endpoint_id           = null
  vpc_peering_connection_id = null
}]

single_nat_gateway           = true
manage_default_network_acl   = false
default_network_acl_tags     = null
public_dedicated_network_acl = true
public_acl_tags              = null
public_inbound_acl_rules = [{
  rule_number = 100
  rule_action = "allow"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_block  = "0.0.0.0/0"
}]

public_outbound_acl_rules = [{
  rule_number = 100
  rule_action = "allow"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_block  = "0.0.0.0/0"
}]

private_dedicated_network_acl = true
private_acl_tags = {
  "key" = "value"
}

private_inbound_acl_rules = [{
  rule_number = 100
  rule_action = "allow"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_block  = "0.0.0.0/0"
}]

private_outbound_acl_rules = [{
  rule_number = 100
  rule_action = "allow"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_block  = "0.0.0.0/0"
}]

enable_nat_gateway = false

customer_gateways = {
  IP1 = {
    bgp_asn     = 65112
    ip_address  = "1.2.3.4"
    device_name = "test"
  },
  IP2 = {
    bgp_asn    = 65112
    ip_address = "5.6.7.8"
  }
}

timeouts = {
  "create" = "5m"
  "update" = "10m"
  "delete" = "5m"
}

## Flow log variables.
enable_flow_log = true
create_flow_log_cloudwatch_log_group  = true
create_flow_log_cloudwatch_iam_role = true

############################# Tranit Gateway #############################

create_tgw                  = true
amazon_side_asn             = 64532
transit_gateway_cidr_blocks = ["0.0.0.0/0"]
vpc_attachments = {
  dns_support  = true
  ipv6_support = false

  transit_gateway_default_route_table_association = true
  transit_gateway_default_route_table_propagation = true

  tgw_routes = [
    {
      destination_cidr_block = "0.0.0.0/0"
    },
    {
      blackhole              = true
      destination_cidr_block = "0.0.0.0/0"
    }
  ]
}

secret_manager = {
  name = "test-3"
}

############################# SQS #############################
create                            = true
content_based_deduplication       = false
deduplication_scope               = null
delay_seconds                     = 0
fifo_queue                        = false
fifo_throughput_limit             = null
kms_data_key_reuse_period_seconds = null
kms_master_key_id                 = null
max_message_size                  = 2048
message_retention_seconds         = 345600
sqs_name                              = "test-sqs"
use_name_prefix                   = false
receive_wait_time_seconds         = 1
redrive_allow_policy              = ""
redrive_policy                    = ""
sqs_managed_sse_enabled           = true
visibility_timeout_seconds        = 30
sqs_tags = {
  name = "testing-sqs"
  env  = "dev"
}

## queue policy variables.
create_queue_policy             = true
source_queue_policy_documents   = []
override_queue_policy_documents = []
queue_policy_statements = {
  "que-policy-test" = {
    actions = [ "SQS:*" ]
    conditions = { }
    effect = "Allow"
    not_actions = null
    not_principals = {}
    not_resources = null
    principals = {
      "principals1" = {
        identifiers = [ "arn:aws:iam::382760063545:root" ]
        type = "AWS"
      }
    }
    resources = ["arn:aws:sqs:us-east-1:382760063545:test-sqs"]
    sid = "test"
  }
}

############################# api-gateway #############################
create_api_gateway  = true
protocol_type = "HTTP"
integrations = {
  "key" = {
    "data_trace_enabled"                  = null
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

create_api_domain_name  = false
create_default_stage    = true
default_stage_access_log_destination_arn  = null
default_stage_access_log_format = null

default_route_settings = {
  "data_trace_enabled"       = null
  "logging_level"            = null
  "detailed_metrics_enabled" = false
  "throttling_burst_limit"   = null
  "throttling_rate_limit"    = null
}

create_routes_and_integrations  = true
create_vpc_link                 = true