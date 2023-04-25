################################################################################
# Queue
################################################################################

locals {
  name = try(trimsuffix(var.name, ".fifo"), "")
}

resource "aws_sqs_queue" "test_queue" {
  count = var.create ? 1 : 0

  content_based_deduplication       = var.content_based_deduplication
  deduplication_scope               = var.deduplication_scope
  delay_seconds                     = var.delay_seconds
  fifo_queue                        = var.fifo_queue
  fifo_throughput_limit             = var.fifo_throughput_limit
  kms_data_key_reuse_period_seconds = var.kms_data_key_reuse_period_seconds
  kms_master_key_id                 = var.kms_master_key_id
  max_message_size                  = var.max_message_size
  message_retention_seconds         = var.message_retention_seconds
  name                              = var.use_name_prefix ? null : (var.fifo_queue ? "${local.name}.fifo" : local.name)
  name_prefix                       = var.use_name_prefix ? "${local.name}-" : null
  receive_wait_time_seconds         = var.receive_wait_time_seconds
  sqs_managed_sse_enabled           = var.kms_master_key_id != null ? null : var.sqs_managed_sse_enabled
  visibility_timeout_seconds        = var.visibility_timeout_seconds

  tags = var.tags
}

################################################################################
# Queue Policy
################################################################################

data "aws_iam_policy_document" "test_doc" {
  count = var.create && var.create_queue_policy ? 1 : 0

  source_policy_documents   = var.source_queue_policy_documents
  override_policy_documents = var.override_queue_policy_documents

  dynamic "statement" {
    for_each = var.queue_policy_statements

    content {
      sid           = try(statement.value.sid, null)
      actions       = try(statement.value.actions, null)
      not_actions   = try(statement.value.not_actions, null)
      effect        = try(statement.value.effect, null)
      resources     = try(statement.value.resources, [aws_sqs_queue.test_queue[count.index].arn])
      not_resources = try(statement.value.not_resources, null)

      dynamic "principals" {
        for_each = try(statement.value.principals, [])

        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }

      dynamic "not_principals" {
        for_each = try(statement.value.not_principals, [])

        content {
          type        = not_principals.value.type
          identifiers = not_principals.value.identifiers
        }
      }

      dynamic "condition" {
        for_each = try(statement.value.conditions, [])

        content {
          test     = condition.value.test
          values   = condition.value.values
          variable = condition.value.variable
        }
      }
    }
  }
}

resource "aws_sqs_queue_policy" "test_policy" {
  count = var.create && var.create_queue_policy ? 1 : 0

  queue_url = aws_sqs_queue.test_queue[count.index].url
  policy    = data.aws_iam_policy_document.test_doc[count.index].json
}