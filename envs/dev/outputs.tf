output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}
output "webserver1_public_ip" {
  value = aws_instance.webserver1.public_ip
}
