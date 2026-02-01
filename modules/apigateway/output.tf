output "invoke_url" {
  description = "API invoke URL"
  value       = aws_apigatewayv2_stage.this.invoke_url
}

output "api_id" {
  description = "HTTP API ID"
  value       = aws_apigatewayv2_api.this.id
}

output "vpclink_id" {
  description = "VPC Link ID"
  value       = aws_apigatewayv2_vpc_link.this.id
}

output "nlb_arn" {
  description = "Looked-up NLB ARN"
  value       = data.aws_lb.nlb.arn
}
