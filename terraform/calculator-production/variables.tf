variable "aws_region" {
  description = "AWS region for calculator production"
  type        = string
  default     = "ap-southeast-1"
}

variable "vpc_cidr" {
  description = "Production VPC CIDR"
  type        = string
  default     = "10.20.0.0/16"
}

variable "availability_zones" {
  description = "Availability zones used by production"
  type        = list(string)
  default = [
    "ap-southeast-1a",
    "ap-southeast-1b"
  ]
}
