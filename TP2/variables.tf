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

variable "s3_bucket_name" {
  description = "Nom du bucket S3"
  type        = string
  default     = "mon-bucket-s3-local"
}

variable "default_port" {
  description = "Port par défaut à ouvrir dans le Security Group"
  type        = number
  default     = 80
}

variable "db_instance_type" {
  description = "Type d'instance BDD"
  type        = string
  default     = "t2.micro"
}

