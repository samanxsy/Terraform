resource "aws_security_group" "ec2" {
  name        = "ec2_sg"
  description = "Allow traffic to EC2 instances"

  vpc_id = aws_vpc.vpcx.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "load_balancer" {
  name        = "LB_SG"
  description = "Allow traffic to Load Balancer"

  vpc_id = aws_vpc.vpcx.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# VPC
resource "aws_vpc" "vpcx" {
  cidr_block = var.vpc_cidr
  tags = {
    Name  = var.aws_vpc_name
    Group = "variablex"
  }
}

# Public Subnets
resource "aws_subnet" "public" {
  count             = length(var.subnet_cidr)
  vpc_id            = aws_vpc.vpcx.id
  cidr_block        = element(var.subnet_cidr, count.index)
  availability_zone = element(var.azs, count.index)
  tags = {
    Name  = "Subnetx-${count.index + 1}"
    Group = "variablex"
  }
}

# Internet GateWay
resource "aws_internet_gateway" "Gatewayx" {
  vpc_id = aws_vpc.vpcx.id
  tags = {
    Name  = var.aws_igw_name
    Group = "variablex"
  }
}

# RoutTable : Attach Internet GateWay
resource "aws_route_table" "route_tablex" {
  vpc_id = aws_vpc.vpcx.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Gatewayx.id
  }
  tags = {
    Name  = var.aws_rt_name
    Group = "variablex"
  }
}

# Route Table association with the Public Subnets
resource "aws_route_table_association" "association" {
  count          = length(var.subnet_cidr)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.route_tablex.id
}
