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
# Variable for existing ECS Task Execution Role ARN
variable "ecs_task_execution_role_arn" {
  description = "ARN of an existing ECS Task Execution Role for Strapi"
  default     = "arn:aws:iam::811738710312:role/ecsTaskExecutionRole"  # replace with your actual existing role ARN
}
