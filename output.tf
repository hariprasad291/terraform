output "vpc_id" {
  description = "The ID of the VPC"
  value       = try(module.network.vpc_id, "") 
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = try(module.network.private_subnets, "")
}

################################################################################
# Queue
################################################################################

# output "queue_id" {
#   description = "The URL for the created Amazon SQS queue"
#   value       = try(module.install.test_queue[0].id, null)
# }

# output "queue_url" {
#   description = "Same as `queue_id`: The URL for the created Amazon SQS queue"
#   value       = try(module.install.aws_sqs_queue.test_queue[0].url, null)
# }

# output "queue_name" {
#   description = "The name of the SQS queue"
#   value       = try(module.install.name, null)
# }
