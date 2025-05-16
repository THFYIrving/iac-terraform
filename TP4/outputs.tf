output "ami_id" {
  description = "ID de l'AMI utilisée"
  value       = data.aws_ami.ubuntu.id
}

output "ansible_command" {
  description = "Commande Ansible prête à utiliser"
  value       = "ansible-playbook -i inventory.ini -u ubuntu --private-key=deployer.pem nginx.yml"
}

output "instance_ips_ec2" {
  description = "IP publiques des instances EC2"
  value       = aws_instance.web[*].public_ip
}
