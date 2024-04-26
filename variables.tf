# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

# variable "aws_access_key" {
#   description = "AWS Access Key"
#   type        = string
#   sensitive   = true
# }

# variable "aws_secret_key" {
#   description = "AWS Secret Key"
#   type        = string
#   sensitive   = true
# }
