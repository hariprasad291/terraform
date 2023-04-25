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

variable "name" {
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

variable "tags" {
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

#########################################################################
# api-gateway
#########################################################################
# variable "create" {
#   description = "Controls if API Gateway resources should be created"
#   type        = bool
#   default     = true
# }

variable "create_api_gateway" {}

variable "create_default_stage" {}

variable "create_default_stage_api_mapping" {
  description = "Whether to create default stage API mapping"
  type        = bool
  default     = true
}

# variable "create_stage" {
#   description = "Whether to create custom stage"
#   type        = bool
#   default     = false
# }
#
# variable "create_stage_api_mapping" {
#   description = "Whether to create stage API mapping"
#   type        = bool
#   default     = false
# }

variable "create_api_domain_name" {}

variable "create_routes_and_integrations" {
  description = "Whether to create routes and integrations resources"
  type        = bool
  default     = false
}

variable "create_vpc_link" {}

# API Gateway
# variable "name" {
#   description = "The name of the API"
#   type        = string
#   default     = "test"
# }

variable "description" {
  description = "The description of the API."
  type        = string
  default     = null
}

variable "default_route_settings" {}

variable "disable_execute_api_endpoint" {
  description = "Whether clients can invoke the API by using the default execute-api endpoint. To require that clients use a custom domain name to invoke the API, disable the default endpoint"
  type        = string
  default     = false
}

variable "protocol_type" {}

variable "api_key_selection_expression" {
  description = "An API key selection expression. Valid values: $context.authorizer.usageIdentifierKey, $request.header.x-api-key."
  type        = string
  default     = "$request.header.x-api-key"
}

variable "route_selection_expression" {
  description = "The route selection expression for the API."
  type        = string
  default     = "$request.method $request.path"
}

variable "cors_configuration" {
  description = "The cross-origin resource sharing (CORS) configuration. Applicable for HTTP APIs."
  type        = map(any)
  default = {
    "cross-origin" = {
      "allow_credentials" = ""
      "allow_headers"     = ""
      "allow_methods"     = ""
      "allow_origins"     = ""
      "expose_headers"    = ""
      "max_age"           = ""
    }
  }
}

variable "body" {
  description = "An OpenAPI specification that defines the set of routes and integrations to create as part of the HTTP APIs. Supported only for HTTP APIs."
  type        = string
  default     = null
}

variable "api_version" {
  description = "A version identifier for the API"
  type        = number
  default     = null
}

# variable "tags" {
#   description = "A mapping of tags to assign to API gateway resources."
#   type        = map(string)
#   default     = {}
# }

#####
# default stage
variable "default_stage_access_log_destination_arn" {}

variable "default_stage_access_log_format" {}

variable "default_stage_tags" {
  description = "A mapping of tags to assign to the default stage resource."
  type        = map(string)
  default     = {}
}

#####
# default stage API mapping

####
# domain name
variable "domain_name" {
  description = "The domain name to use for API gateway"
  type        = string
  default     = null
}

variable "domain_name_certificate_arn" {
  description = "The ARN of an AWS-managed certificate that will be used by the endpoint for the domain name"
  type        = string
  default     = null
}

variable "domain_name_ownership_verification_certificate_arn" {
  description = "ARN of the AWS-issued certificate used to validate custom domain ownership (when certificate_arn is issued via an ACM Private CA or mutual_tls_authentication is configured with an ACM-imported certificate.)"
  type        = string
  default     = null
}

variable "domain_name_tags" {
  description = "A mapping of tags to assign to API domain name resource."
  type        = map(string)
  default     = {}
}

variable "mutual_tls_authentication" {
  description = "An Amazon S3 URL that specifies the truststore for mutual TLS authentication as well as version, keyed at uri and version"
  type        = map(string)
  default     = {}
}

####
# routes and integrations
variable "integrations" {}

# authorrizers
variable "authorizers" {
  description = "Map of API gateway authorizers"
  type        = map(any)
  default     = {}
}

# vpc link
variable "vpc_links" {
  description = "Map of VPC Links details to create"
  type        = map(any)
  default = {
    "vpc1" = {
      "name"               = "hari"
      "security_group_ids" = []
      "subnet_ids"         = ["subnet-0ed01cb0d45e7fb42", "subnet-019964c0f9cecf1a0"]
    }
  }
}

variable "vpc_link_tags" {
  description = "A map of tags to add to the VPC Link"
  type        = map(string)
  default     = {}
}