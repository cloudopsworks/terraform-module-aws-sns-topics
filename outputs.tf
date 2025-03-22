##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#

output "sns_topics" {
  value = {
    for k, v in aws_sns_topic.this : k => {
      arn = v.arn
    }
  }
}

output "sns_topic_subscriptions" {
  value = {
    for k, v in aws_sns_topic_subscription.this : k => {
      topic_arn                      = v.topic_arn
      protocol                       = v.protocol
      endpoint                       = v.endpoint
      confirmation_was_authenticated = v.confirmation_was_authenticated
      pending_confirmation           = v.pending_confirmation
    }
  }
}