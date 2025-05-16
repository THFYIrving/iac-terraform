# Instance EC2 principale
resource "aws_instance" "ec2_web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  security_groups = [aws_security_group.web.name]
  key_name      = aws_key_pair.deployer.key_name

  tags = {
    Name = var.instance_name
    Role = "web"
  }
}

