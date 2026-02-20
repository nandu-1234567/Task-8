variable "region" {
  default = "us-east-1"
}

variable "cluster_name" {
  default = "strapi-cluster"
}

variable "service_name" {
  default = "strapi-service"
}

variable "task_family" {
  default = "strapi-task"
}

variable "cpu" {
  default = "512"
}

variable "memory" {
  default = "1024"
}

variable "log_group_name" {
  default = "/ecs/strapi"
}
