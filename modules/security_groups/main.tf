resource "aws_security_group" "workers" {
  name        = "${var.cluster_name}-workers-sg"
  description = "Security group for EKS worker nodes"
  vpc_id      = var.vpc_id

  # allow nodes to communicate with each other
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = var.intra_node_protocol
    self        = true
    description = "Allow intra-node communication"
  }

  # allow nodes to communicate with EKS control plane
  ingress {
    from_port   = var.control_plane_port
    to_port     = var.control_plane_port
    protocol    = var.control_plane_protocol
    cidr_blocks = [var.vpc_cidr]
    description = "Allow nodes to reach control plane"
  }

  # allow all outbound traffic
  egress {
    from_port   = var.egress_from_port
    to_port     = var.egress_to_port
    protocol    = var.egress_protocol
    cidr_blocks = var.egress_cidr_blocks
  }

  tags = { Name = "${var.cluster_name}-workers-sg" }
}

output "workers_sg_id" {
  value = aws_security_group.workers.id
}
