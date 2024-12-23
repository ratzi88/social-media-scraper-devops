variable "tags" {
  type        = map(string)
  description = "Common tags for all resources"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zones for subnets"
  default     = ["eu-central-1a", "eu-central-1b"]
}
