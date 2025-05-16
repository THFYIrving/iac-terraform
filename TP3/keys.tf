resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "local_file" "private-key" {
  content = tls_private_key.ssh_key.private_key_pem
  filename = "${path.module}/private.pem"
}
