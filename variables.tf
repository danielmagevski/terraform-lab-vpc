variable "aws_region" {
  type        = string
  description = ""
  default     = "us-east-1"
}
variable "enable_dns_hostnames" {
  description = ""
  type        = bool
  default     = true
}
variable "enable_dns_support" {
  description = ""
  type        = bool
  default     = true
}
