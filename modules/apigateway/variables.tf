variable "name" {
  type        = string
  description = "API Gateway HTTP API name"
}

variable "stage_name" {
  type        = string
  description = "Stage name, e.g. dev"
}

variable "route_key" {
  type        = string
  description = "Route key, e.g. ANY /{proxy+}"
}

variable "vpc_id" {
  type        = string
  description = "VPC id for VPC Link SG"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Private subnet ids for VPC Link"
}

variable "k8s_service_namespace" {
  type        = string
  description = "Kubernetes namespace of the Service that created the NLB"
}

variable "k8s_service_name" {
  type        = string
  description = "Kubernetes Service name that created the NLB"
}

variable "nlb_listener_port" {
  type        = number
  description = "NLB listener port (usually 80)"
}

variable "tags" {
  type        = map(string)
  default     = {}
}

