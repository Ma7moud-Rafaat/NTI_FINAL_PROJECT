variable "cluster_name" {
type = string
}
variable "k8s_version" {
type = string
}
variable "vpc_id" {
}
variable "subnet_ids" {
  type = list(string)
}
variable "node_instance_types" {
    type = list(any)
}
variable "capacity_type" {
    type = string
}
variable "node_desired_size" {
    type = number
}
variable "node_min_size" {
    type = number
}
variable "node_max_size" {
    type = number
}
variable "max_unavailable" {
  type = number
}
ariable "enable_node_remote_access" {
  type        = bool
  description = "Enable SSH remote access to EKS nodes"
  default     = false

  validation {
    condition     = (!var.enable_node_remote_access) || (length(var.ssh_key_name) > 0)
    error_message = "When enable_node_remote_access is true, ssh_key_name must be non-empty."
  }
}
variable "ssh_key_name" {
  type        = string
  description = "EC2 key pair name for node remote access. Leave empty if remote access is disabled."
  default     = ""
}
