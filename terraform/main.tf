rovider "aws" {
  region = var.aws_region
}

########################
# Data: Default VPC
########################

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

########################
# Security Group
########################

resource "aws_security_group" "ecs_sg" {
  name   = "strapi-sg"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

########################
# ECS Cluster
########################

resource "aws_ecs_cluster" "main" {
  name = "strapi-cluster"
   setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

########################
# CloudWatch Log Group
########################

resource "aws_cloudwatch_log_group" "strapi_logs" {
  name              = "/ecs/strapi1"
  retention_in_days = 7
}

########################
# ECS Task Definition
########################

resource "aws_ecs_task_definition" "strapi" {
  family                   = "strapi"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "512"
  memory                   = "1024"

  # IMPORTANT: Replace this with your real account ID if different
  execution_role_arn = "arn:aws:iam::811738710312:role/ecsTaskExecutionRole"

  container_definitions = jsonencode([
    {
      name      = "strapi"
      image     = var.ecr_image_uri
      essential = true

      portMappings = [
        {
          containerPort = 1337
          protocol      = "tcp"
        }
      ]

      environment = [
        { name = "HOST", value = "0.0.0.0" },
        { name = "PORT", value = "1337" },
        { name = "APP_KEYS", value = "key1,key2,key3,key4" },
        { name = "API_TOKEN_SALT", value = "salt" },
        { name = "ADMIN_JWT_SECRET", value = "adminsecret" },
        { name = "TRANSFER_TOKEN_SALT", value = "transfersalt" },
        { name = "ENCRYPTION_KEY", value = "encryptkey" },
        { name = "JWT_SECRET", value = "jwtsecret" }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/strapi1"
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

########################
# ECS Service
########################

resource "aws_ecs_service" "strapi_service" {
  name            = "strapi-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.strapi.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = data.aws_subnets.default.ids
    security_groups  = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  depends_on = [aws_cloudwatch_log_group.strapi_logs]
  wait_for_steady_state = true
}

resource "aws_cloudwatch_dashboard" "strapi_dashboard" {
  dashboard_name = "Strapi-ECS-Dashboard"
  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric",
        x = 0,
        y = 0,
        width = 12,
        height = 6,
        properties = {
          metrics = [
            [ "ECS/ContainerInsights", "CPUUtilization", "ClusterName", "strapi-cluster" ],
            [ ".", "MemoryUtilization", ".", "." ]
          ],
          period = 300,
          stat   = "Average",
          region = var.aws_region,
          title  = "Strapi ECS CPU & Memory"
        }
      }
    ]
  })
}
