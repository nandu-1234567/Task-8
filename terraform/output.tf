output "application_url" {
  value = "http://${aws_lb.alb.dns_name}"
}
output "ecs_task_execution_role_arn" {
  value       = var.ecs_task_execution_role_arn
  description = "ARN of ECS Task Execution Role for Strapi"
}
