variable "project" {
  description = "Name of the project"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "azs" {
  description = "Availability zones"
  type        = list(string)
}
variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
  default     = []
}