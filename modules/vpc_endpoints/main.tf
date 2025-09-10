# ==========================
# Security Group for Interface Endpoints
# ==========================
resource "aws_security_group" "endpoints_sg" {
  name        = "${var.cluster_name}-endpoints-sg"
  description = "Security group for interface endpoints"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.sg_ingress_from_port
    to_port     = var.sg_ingress_to_port
    protocol    = var.sg_ingress_protocol
    cidr_blocks = [var.sg_ingress_cidr]
  }

  egress {
    from_port   = var.sg_egress_from_port
    to_port     = var.sg_egress_to_port
    protocol    = var.sg_egress_protocol
    cidr_blocks = var.sg_egress_cidr
  }

  tags = {
    Name = "${var.cluster_name}-endpoints-sg"
  }
}

# ==========================
# Gateway Endpoint for S3
# ==========================
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.aws_region}.${var.s3_service_name}"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = var.route_table_ids
  tags = {
    Name = "${var.cluster_name}-s3-endpoint"
  }
}

# ==========================
# Interface Endpoints
# ==========================
resource "aws_vpc_endpoint" "interface_endpoints" {
  for_each           = toset(var.interface_endpoints)
  vpc_id             = var.vpc_id
  service_name       = "com.amazonaws.${var.aws_region}.${each.key}"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = var.private_subnet_ids
  security_group_ids = [aws_security_group.endpoints_sg.id]
  private_dns_enabled = true

  tags = {
    Name = "${var.cluster_name}-${each.key}-endpoint"
  }
}
