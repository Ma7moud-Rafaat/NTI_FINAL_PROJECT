locals {
  k8s_service_tag = "${var.k8s_service_namespace}/${var.k8s_service_name}"
}

resource "aws_apigatewayv2_api" "NTI_API" {
  name          = var.name
  protocol_type = "HTTP"
  tags          = var.tags
}
resource "aws_security_group" "vpclink" {
  name        = "${var.name}-vpclink-sg"
  description = "SG for API Gateway VPC Link"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}
resource "aws_apigatewayv2_vpc_link" "NTI_VPC_LINK" {
  name               = "${var.name}-vpclink"
  subnet_ids         = var.private_subnet_ids
  security_group_ids = [aws_security_group.vpclink.id]
  tags               = var.tags
}

data "aws_lb" "nlb" {
  tags = {
    "kubernetes.io/service-name" = local.k8s_service_tag
  }
}

data "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = data.aws_lb.nlb.arn
  port              = var.nlb_listener_port
}

resource "aws_apigatewayv2_integration" "NTI_INTEGRATION" {
  api_id           = aws_apigatewayv2_api.NTI_API.id
  integration_type = "HTTP_PROXY"

  connection_type = "VPC_LINK"
  connection_id   = aws_apigatewayv2_vpc_link.NTI_VPC_LINK.id

  integration_uri        = data.aws_lb_listener.nlb_listener.arn
  integration_method     = "ANY"
  payload_format_version = "1.0"
}

# 7) Route → integration
resource "aws_apigatewayv2_route" "NTI_ROUTES" {
  api_id    = aws_apigatewayv2_api.NTI_API.id
  route_key = var.route_key
  target    = "integrations/${aws_apigatewayv2_integration.NTI_INTEGRATION.id}"
}
resource "aws_apigatewayv2_route" "root" {
  api_id    = aws_apigatewayv2_api.NTI_API.id
  route_key = "ANY /"
  target    = "integrations/${aws_apigatewayv2_integration.NTI_INTEGRATION.id}"
}


resource "aws_apigatewayv2_stage" "NTI_STAGES" {
  api_id      = aws_apigatewayv2_api.NTI_API.id
  name        = var.stage_name
  auto_deploy = true
  tags        = var.tags
}
