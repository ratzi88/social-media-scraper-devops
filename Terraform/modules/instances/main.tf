resource "aws_instance" "mongo" {
  ami             = "ami-0a628e1e89aaedf80"
  instance_type   = "t2.micro"
  subnet_id       = element(var.private_subnets, 0)
  tags            = var.tags

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y mongodb
              EOF
}
