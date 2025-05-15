terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.5.0"
    }
  }
}

provider "docker" {
  host = "tcp://localhost:2375"
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "nginx" {
  name  = var.conteneur_id
  image = var.image_docker
  ports {
    internal = var.port_int_id
    external = var.port_exp_id
  }

  networks_advanced {
  name = docker_network.app_network.name
  aliases = ["nginx"]
  }


provisioner "local-exec" {
    command = "curl http://localhost:${var.port_exp_id} | findstr /I Welcome && echo ✅ Nginx est actif et affiche 'Welcome'"
    }
}

resource "docker_network" "app_network" {
  name = "nginx_client_network"
  }
resource "docker_image" "curl" {
  name         = "appropriate/curl"
  keep_locally = true
}

resource "docker_container" "client" {
  count = var.num_cli
  
  name  = "client-${count.index}"
  image = docker_image.curl.image_id
  command = ["sh", "-c", "curl http://nginx:80 && sleep 30"]

  networks_advanced {
    name = docker_network.app_network.name
  }

  depends_on = [docker_container.nginx]
}

resource "docker_container" "foreach" {
  for_each = toset(var.nom_srv)
  
  name  = "server-${each.key}"
  image = docker_image.curl.image_id
  command = ["sh", "-c", "curl http://nginx:80 && sleep 30"]

  networks_advanced {
    name = docker_network.app_network.name
  }

  depends_on = [docker_container.nginx]
}



