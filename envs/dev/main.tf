module "vpc" {
  source         = "../../modules/vpc"
  project        = var.project
  vpc_cidr       = "10.0.0.0/16"
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  azs            = ["us-east-1a", "us-east-1b"]
}

module "sg_web" {
  source   = "../../modules/sg"
  project  = var.project
  vpc_id   = module.vpc.vpc_id
}

module "alb" {
  source             = "../../modules/alb"
  project            = var.project
  vpc_id             = module.vpc.vpc_id
  public_subnets     = module.vpc.public_subnet_ids
  security_group_id  = module.sg_web.sg_id
  instance_id        = aws_instance.webserver1.id
}

resource "aws_instance" "webserver1" {
  ami                         = "ami-0c7217cdde317cfec" # Amazon Linux 2023 (us-east-1)
  instance_type               = "t2.micro"
  subnet_id                   = module.vpc.public_subnet_ids[0]
  vpc_security_group_ids      = [module.sg_web.sg_id]
  associate_public_ip_address = true
  key_name                    = "newkey"

  tags = {
    Name = "${var.project}-webserver1"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl enable httpd
              systemctl start httpd
              echo "<h1>Webserver 1 is running</h1>" > /var/www/html/index.html
              EOF
}
