variable "vpc_id" {
  type        = string
  description = "VPC ID for the security group"
}

variable "tags" {
  type        = map(string)
  description = "Tags for resources"
}
