variable "project" {}
variable "vpc_id" {}
variable "public_subnets" {
  type = list(string)
}
variable "security_group_id" {}
variable "instance_id" {}
