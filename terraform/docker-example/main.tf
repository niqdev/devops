terraform {
  required_providers {
    # https://github.com/kreuzwerker/terraform-provider-docker
    # https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs
    docker = {
      # shorthand for "registry.terraform.io/kreuzwerker/docker"
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {
  host = var.docker_host
}

# resource <type> <name> defines components of the infrastructure
# the prefix of the type maps to the name of the provider i.e. "docker_"
# resource <type> and <name> form a unique ID i.e. "docker_image.nginx"
resource "docker_image" "nginx" {
  # arguments
  name         = local.image_name
  keep_locally = false
}

resource "docker_container" "my-nginx" {
  image = docker_image.nginx.image_id
  name  = local.container_name
  ports {
    internal = local.container_port
    external = local.host_port
  }
}

output "port_message" {
  description = "host/container port mapping"
  value       = "Exposed port: ${local.host_port} -> ${local.container_port}"
}

output "container_info" {
  value = {
    container_id   = docker_container.my-nginx.id
    container_name = docker_container.my-nginx.name
    image_id       = docker_image.nginx.image_id
    image_name     = docker_image.nginx.image_id
  }
}
