variable "image_docker" {
  description = "variable de l'image docker"
  type        = string
  default     = "nginx:latest"
}
variable "conteneur_id" {
  description = "Nom du conteneur"
  type        = string
  default     = "my_nginx_container"
}
variable "port_int_id" {
  description = "Port exposé à l'intérieur du conteneur"
  type        = number
  default     = 80
}
variable "port_exp_id" {
  description = "Port exposé sur la machine hôte"
  type        = number
  default     = 8080
}
variable "num_cli" {
  description = "Nombre de conteneurs client à lancer"
  type        = number
  default     = 3
}
variable "nom_srv" {
  description = "Liste des noms pour les conteneurs client"
  type        = list(string)
  default     = ["riri", "fifi", "loulou"]
}
variable "machines" {
  description = "Liste des machines à déployer, avec nom, vCPU, disque et région"
  type = list(object({
    name      = string
    vcpu      = number
    disk_size = number
    region    = string
  }))

  validation {
    condition = alltrue([
      for m in var.machines :
      m.vcpu >= 2 && m.vcpu <= 64
    ])
    error_message = "Chaque machine doit avoir entre 2 et 64 vCPU."
  }

  validation {
    condition = alltrue([
      for m in var.machines :
      m.disk_size >= 20
    ])
    error_message = "Chaque machine doit avoir une taille de disque d'au moins 20 Go."
  }

  validation {
    condition = alltrue([
      for m in var.machines :
      contains(["eu-west-1", "us-east-1", "ap-southeast-1"], m.region)
    ])
    error_message = "La région doit être parmi : eu-west-1, us-east-1, ap-southeast-1."
  }
}
