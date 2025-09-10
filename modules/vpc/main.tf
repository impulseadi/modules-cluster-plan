# ==========================
# Data Sources
# ==========================
data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  azs = length(var.availability_zones) > 0 ? var.availability_zones : slice(data.aws_availability_zones.available.names, 0, 2)
}

# ==========================
# VPC
# ==========================
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = {
    Name = "${var.cluster_name}-vpc"
  }
}

# ==========================
# Internet Gateway
# ==========================
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.cluster_name}-igw"
  }
}

# ==========================
# Public Subnets
# ==========================
resource "aws_subnet" "public" {
  for_each                = { for idx, cidr in var.public_subnets_cidrs : idx => cidr }
  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value
  availability_zone       = local.azs[tonumber(each.key)]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.cluster_name}-public-${each.key}"
  }
}

# ==========================
# NAT Gateway
# ==========================
resource "aws_eip" "nat" {
  tags = {
    Name = "${var.cluster_name}-nat-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.allocation_id

  subnet_id     = values(aws_subnet.public)[0].id
  depends_on    = [aws_internet_gateway.igw]

  tags = {
    Name = "${var.cluster_name}-natgw"
  }
}

# ==========================
# Private Subnets
# ==========================
resource "aws_subnet" "private" {
  for_each                = { for idx, cidr in var.private_subnets_cidrs : idx => cidr }
  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value
  availability_zone       = local.azs[tonumber(each.key)]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.cluster_name}-private-${each.key}"
  }
}

# ==========================
# Route Tables
# ==========================
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = var.public_route_cidr
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.cluster_name}-public-rt"
  }
}

resource "aws_route_table_association" "public_assoc" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = var.private_route_cidr
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "${var.cluster_name}-private-rt"
  }
}

resource "aws_route_table_association" "private_assoc" {
  for_each       = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}

# ==========================
# VPC Endpoints
# ==========================
resource "aws_security_group" "endpoints_sg" {
  name        = var.vpce_sg_name
  description = var.vpce_sg_description
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port   = var.vpce_ingress_from_port
    to_port     = var.vpce_ingress_to_port
    protocol    = var.vpce_ingress_protocol
    cidr_blocks = var.vpce_ingress_cidr_blocks
  }

  egress {
    from_port   = var.vpce_egress_from_port
    to_port     = var.vpce_egress_to_port
    protocol    = var.vpce_egress_protocol
    cidr_blocks = var.vpce_egress_cidr_blocks
  }

  tags = {
    Name = var.vpce_sg_name
  }
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.${var.aws_region}.${var.s3_service_name}"
  vpc_endpoint_type = var.s3_vpc_endpoint_type
  route_table_ids   = [aws_route_table.private.id, aws_route_table.public.id]

  tags = {
    Name = "${var.cluster_name}-s3-endpoint"
  }
}

resource "aws_vpc_endpoint" "interface_endpoints" {
  for_each            = toset(var.interface_endpoints)
  vpc_id              = aws_vpc.this.id
  service_name        = "com.amazonaws.${var.aws_region}.${each.key}"
  vpc_endpoint_type   = var.interface_vpc_endpoint_type
  subnet_ids          = [for s in aws_subnet.private : s.id]
  security_group_ids  = [aws_security_group.endpoints_sg.id]
  private_dns_enabled = var.private_dns_enabled

  tags = {
    Name = "${var.cluster_name}-${each.key}-endpoint"
  }
}

# ==========================
# Bastion Host
# ==========================
resource "aws_security_group" "bastion_sg" {
  name   = "${var.cluster_name}-bastion-sg"
  vpc_id = aws_vpc.this.id

  dynamic "ingress" {
    for_each = var.bastion_ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.bastion_egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = "${var.cluster_name}-bastion-sg"
  }
}

resource "aws_instance" "bastion" {
  ami                    = var.bastion_ami
  instance_type          = var.bastion_instance_type
  subnet_id              = values(aws_subnet.public)[0].id
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  key_name               = var.bastion_key_name

  tags = {
    Name = "${var.cluster_name}-bastion"
  }
}


# data "aws_availability_zones" "available" {
#   state = "available"
# }

# locals {
#   azs = length(var.availability_zones) > 0 ? var.availability_zones : slice(data.aws_availability_zones.available.names, 0, 2)
# }

# resource "aws_vpc" "this" {
#   cidr_block           = var.vpc_cidr
#   enable_dns_hostnames = var.enable_dns_hostnames
#   enable_dns_support   = var.enable_dns_support
#   tags = {
#     Name = "${var.cluster_name}-vpc"
#   }
# }

# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.this.id
#   tags = {
#     Name = "${var.cluster_name}-igw"
#   }
# }

# resource "aws_subnet" "public" {
#   for_each                = { for idx, cidr in var.public_subnets_cidrs : idx => cidr }
#   vpc_id                  = aws_vpc.this.id
#   cidr_block              = each.value
#   availability_zone       = local.azs[tonumber(each.key)]
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "${var.cluster_name}-public-${each.key}"
#   }
# }

# resource "aws_eip" "nat" {
#   tags = {
#     Name = "${var.cluster_name}-nat-eip"
#   }
# }

# resource "aws_nat_gateway" "nat" {
#   allocation_id = aws_eip.nat.id
#   subnet_id     = aws_subnet.public[0].id
#   tags = {
#     Name = "${var.cluster_name}-natgw"
#   }
#   depends_on = [aws_internet_gateway.igw]
# }

# resource "aws_subnet" "private" {
#   for_each                = { for idx, cidr in var.private_subnets_cidrs : idx => cidr }
#   vpc_id                  = aws_vpc.this.id
#   cidr_block              = each.value
#   availability_zone       = local.azs[tonumber(each.key)]
#   map_public_ip_on_launch = false
#   tags = {
#     Name = "${var.cluster_name}-private-${each.key}"
#   }
# }

# resource "aws_route_table" "public" {
#   vpc_id = aws_vpc.this.id
#   route {
#     cidr_block = var.public_route_cidr
#     gateway_id = aws_internet_gateway.igw.id
#   }
#   tags = {
#     Name = "${var.cluster_name}-public-rt"
#   }
# }

# resource "aws_route_table_association" "public_assoc" {
#   for_each       = aws_subnet.public
#   subnet_id      = each.value.id
#   route_table_id = aws_route_table.public.id
# }

# resource "aws_route_table" "private" {
#   vpc_id = aws_vpc.this.id
#   route {
#     cidr_block     = var.private_route_cidr
#     nat_gateway_id = aws_nat_gateway.nat.id
#   }
#   tags = {
#     Name = "${var.cluster_name}-private-rt"
#   }
# }

# resource "aws_route_table_association" "private_assoc" {
#   for_each       = aws_subnet.private
#   subnet_id      = each.value.id
#   route_table_id = aws_route_table.private.id
# }

# resource "aws_security_group" "bastion_sg" {
#   name   = "${var.cluster_name}-bastion-sg"
#   vpc_id = aws_vpc.this.id

#   dynamic "ingress" {
#     for_each = var.bastion_ingress_rules
#     content {
#       from_port   = ingress.value.from_port
#       to_port     = ingress.value.to_port
#       protocol    = ingress.value.protocol
#       cidr_blocks = ingress.value.cidr_blocks
#     }
#   }

#   dynamic "egress" {
#     for_each = var.bastion_egress_rules
#     content {
#       from_port   = egress.value.from_port
#       to_port     = egress.value.to_port
#       protocol    = egress.value.protocol
#       cidr_blocks = egress.value.cidr_blocks
#     }
#   }

#   tags = {
#     Name = "${var.cluster_name}-bastion-sg"
#   }
# }
# resource "aws_instance" "bastion" {
#   ami                    = var.bastion_ami
#   instance_type          = var.bastion_instance_type
#   subnet_id              = aws_subnet.public[0].id
#   vpc_security_group_ids = [aws_security_group.bastion_sg.id]
#   key_name               = var.bastion_key_name

#   tags = {
#     Name = "${var.cluster_name}-bastion"
#   }
# }