variable "tags" {
  type        = map(string)
  description = "Common tags for all resources"
  default     = {
    Name = "social-media-scraper"
  }
}
