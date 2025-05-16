variable "instance_type" {
  description = "Type d'instance EC2"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "Nom de l'instance EC2"
  type        = string
  default     = "mon-instance-ec2"
}

variable "key_pair_name" {
  description = "Nom de la paire de clés SSH"
  type        = string
  default     = "deployer-key"
}

variable "ssh_public_key_path" {
  description = "Chemin vers la clé publique SSH"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "bucket_name" {
  description = "Nom du bucket S3 à créer"
  type        = string
  default     = "mon-bucket-test-upload"
}
