output "invoke_url" {
  description = "API invoke URL"
  value       = aws_apigatewayv2_stage.NTI_STAGES.invoke_url
}

output "api_id" {
  description = "HTTP API ID"
  value       = aws_apigatewayv2_api.NTI_API.id
}

output "vpclink_id" {
  description = "VPC Link ID"
  value       = aws_apigatewayv2_vpc_link.NTI_VPC_LINK.id
}

output "nlb_arn" {
  description = "Looked-up NLB ARN"
  value       = data.aws_lb.nlb.arn
}
