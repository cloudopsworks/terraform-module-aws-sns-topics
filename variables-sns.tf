##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#
## Variable Documentation - YAML format
# configs:

variable "configs" {
  description = "A map of configuration sets and their SNS destinations"
  type        = any
  default     = {}
}