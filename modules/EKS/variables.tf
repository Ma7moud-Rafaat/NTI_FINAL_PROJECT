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
  type        = bool
  description = "Enable SSH remote access to EKS nodes"
  default     = false
}
variable "ssh_key_name" {
  type        = string
<<<<<<< HEAD
=======
  description = "EC2 key pair name for node remote access. Leave empty if remote access is disabled."
>>>>>>> 99d40710c9e2a66d0fc4d28a37b6ec204d94311d
  default     = ""
}

