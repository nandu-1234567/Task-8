resource "aws_cloudwatch_log_group" "strapi_logs" {
  name              = var.log_group_name
  retention_in_days = 7
  lifecycle {
    prevent_destroy = false
  }
}
