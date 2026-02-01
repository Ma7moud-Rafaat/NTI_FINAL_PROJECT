resource "aws_eks_node_group" "NTI_NODE_GR" {
  cluster_name    = aws_eks_cluster.NTI_eks.name
  node_group_name = "${var.cluster_name}-ng"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = var.subnet_ids

  instance_types = var.node_instance_types
  capacity_type  = var.capacity_type

  scaling_config {
    desired_size = var.node_desired_size
    min_size     = var.node_min_size
    max_size     = var.node_max_size
  }

  update_config {
    max_unavailable = var.max_unavailable
  }

  dynamic "remote_access" {
    for_each = var.enable_node_remote_access ? [1] : []
    content {
      ec2_ssh_key = var.ssh_key_name
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.worker_node_policy,
    aws_iam_role_policy_attachment.cni_policy,
    aws_iam_role_policy_attachment.ecr_read_only,
  ]
}
