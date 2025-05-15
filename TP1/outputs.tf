output "container_id" {
  description = "ID du Docker container"
  value       = docker_container.nginx.id
}
output "clients_names" {
  value = [for c in docker_container.client : c.name]
}
output "serveur_names" {
  value = [for s in docker_container.foreach : s.name]
}