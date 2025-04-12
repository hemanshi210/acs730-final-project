resource "aws_instance" "webserver1" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id
  key_name      = "newkey"
  vpc_security_group_ids = [var.sg_id]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install apache2 -y
              systemctl start apache2
              echo "<h1>Hello from Terraform on Ubuntu!</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "${var.project}-webserver1"
  }
}
