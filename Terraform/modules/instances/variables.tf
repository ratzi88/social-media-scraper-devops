variable "private_subnets" {
  type        = list(string)
  description = "Private subnets for the instances"
}

variable "tags" {
  type        = map(string)
  description = "Tags to assign to resources"
}
