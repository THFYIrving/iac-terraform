# Génère une chaîne aléatoire pour éviter les conflits de nom de clé
resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

# Génération automatique de la clé SSH
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Création de la paire de clés AWS EC2 avec nom unique
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key-${random_string.suffix.result}"
  public_key = tls_private_key.ssh.public_key_openssh
}

# Enregistrement de la clé privée générée dans un fichier .pem
resource "local_file" "private_key_pem" {
  content         = tls_private_key.ssh.private_key_pem
  filename        = "${path.module}/deployer.pem"
  file_permission = "0600"
}

# Déploiement des instances EC2 Ubuntu
resource "aws_instance" "web" {
  count         = var.instance_count
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.web.id]


  tags = {
    Name = "web-${count.index}"
    Role = "nginx"
  }

  # Supprimé le provisioner ici pour éviter le cycle
}

# Génère l'inventory Ansible dans un fichier .ini
resource "null_resource" "generate_inventory" {
  provisioner "local-exec" {
    command = <<EOT
echo [web] > inventory.ini
${join("\n", aws_instance.web.*.public_ip)} >> inventory.ini
EOT
  }

  depends_on = [aws_instance.web]
}

resource "local_file" "inventory" {
  content  = templatefile("${path.module}/inventory.tpl", {
    ips = aws_instance.web[*].public_ip
  })
  filename = "${path.module}/inventory.ini"
}