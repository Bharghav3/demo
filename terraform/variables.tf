variable "region" {
  description = "The AWS region to deploy in"
  default     = "eu-west-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

# Add more variables as needed
