variable "vpc_id" {
  type        = string
  description = "VPC ID for the EKS cluster"
}

variable "public_subnets" {
  type        = list(string)
  description = "Public subnets for the EKS cluster"
}

variable "private_subnets" {
  type        = list(string)
  description = "Private subnets for the EKS cluster"
}

variable "tags" {
  type        = map(string)
  description = "Tags for resources"
}
