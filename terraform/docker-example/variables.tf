variable "docker_host" {
  description = "Docker daemon socket/endpoint"
  type        = string
  default     = "unix:///var/run/docker.sock"
}
