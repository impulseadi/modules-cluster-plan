# Security Group for EKS Worker Nodes
resource "aws_security_group" "workers" {
  name        = "${var.cluster_name}-workers-sg"
  description = "Security group for EKS worker nodes"
  vpc_id      = var.vpc_id

  # allow nodes to communicate with each other
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
    description = "Allow intra-node communication"
  }

  # allow nodes to communicate with EKS control plane (port 443)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
    description = "Allow nodes to reach control plane"
  }

  # allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.cluster_name}-workers-sg" }
}

# Output the security group ID
output "workers_sg_id" {
  value = aws_security_group.workers.id
}
