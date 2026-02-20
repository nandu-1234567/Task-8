resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole-strapi"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = { Service = "ecs-tasks.amazonaws.com" },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Project     = "Strapi"
    Environment = "Dev"
  }
}

resource "aws_iam_role_policy_attachment" "ecs_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

output "ecs_task_execution_role_arn" {
  value       = aws_iam_role.ecs_task_execution_role.arn
  description = "ARN of ECS Task Execution Role for Strapi"
}
