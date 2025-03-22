##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#

resource "aws_sns_topic" "this" {
  for_each                    = var.configs
  name                        = try(each.value.name, "") != "" ? each.value.name : format("%s-%s-topic", try(each.value.name_prefix, each.key), local.system_name)
  display_name                = try(each.value.display_name, null)
  fifo_topic                  = try(each.value.fifo_topic, null)
  tracing_config              = try(each.value.tracing_config, null)
  policy                      = try(each.value.policy, null)
  delivery_policy             = try(each.value.delivery_policy, null)
  archive_policy              = try(each.value.archive_policy, null)
  kms_master_key_id           = try(each.value.kms_master_key_id, null)
  content_based_deduplication = try(each.value.content_based_deduplication, null)
  signature_version           = try(each.value.signature_version, null)
  tags                        = local.all_tags
}

resource "aws_sns_topic_subscription" "this" {
  for_each = merge([
    for key, config in var.configs : {
      for k, v in try(config.subscriptions, {}) : "${key}-${k}" => {
        topic_key    = key
        sub_key      = k
        subscription = v
      }
    }
  ]...)
  topic_arn                       = aws_sns_topic.this[each.value.topic_key].arn
  protocol                        = each.value.subscription.protocol
  endpoint                        = each.value.subscription.endpoint
  subscription_role_arn           = try(each.value.subscription.role_arn, null)
  confirmation_timeout_in_minutes = try(each.value.subscription.confirmation_timeout_in_minutes, null)
  delivery_policy                 = try(each.value.subscription.delivery_policy, null)
  filter_policy                   = try(each.value.subscription.filter_policy, null)
  raw_message_delivery            = try(each.value.subscription.raw_message_delivery, null)
  redrive_policy                  = try(each.value.subscription.redrive_policy, null)
  replay_policy                   = try(each.value.subscription.replay_policy, null)
}