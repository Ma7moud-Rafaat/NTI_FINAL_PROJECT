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
variable "enable_node_remote_access" {
    type = bool
}
variable "ssh_key_name" {
    type = string
    validation {
    condition     = var.enable_node_remote_access == false || (var.enable_node_remote_access == true && length(var.ssh_key_name) > 0)
    error_message = "ssh_key_name must be set when enable_remote_access=true."
  }
}
