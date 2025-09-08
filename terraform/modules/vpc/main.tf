# 以下を作成します。
# VPC, Subnet, Internet Gateway, Default Route Table, Default Network ACL, Default Security Group

# VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    "Name" = "${var.name}-vpc"
  }
}



# Subnet
resource "aws_subnet" "public_1a" {
  vpc_id = aws_vpc.main.id

  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true # パブリックIPを自動割り当て

  tags = {
    Name = "${var.name}-subnet-public-1a"
  }
}



# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name}-igw"
  }
}



# Default Route Table
resource "aws_default_route_table" "public" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${var.name}-rtb-public"
  }
}
resource "aws_route_table_association" "public_1a" {
  subnet_id      = aws_subnet.public_1a.id
  route_table_id = aws_default_route_table.public.id
}



# Default Network ACL
resource "aws_default_network_acl" "main" {
  default_network_acl_id = aws_vpc.main.default_network_acl_id
  subnet_ids             = [aws_subnet.public_1a.id]

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "${var.name}-acl"
  }
}



# Default Security Group
resource "aws_default_security_group" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name}-sg"
  }
}

## インターネット -> VPC: SSH 許可
# resource "aws_vpc_security_group_ingress_rule" "ingress_ssh" {
#   security_group_id = aws_default_security_group.main.id
#   cidr_ipv4         = "0.0.0.0/0"
#   ip_protocol       = "tcp"
#   from_port         = 22
#   to_port           = 22
# }

## インターネット -> VPC: HTTP 許可
resource "aws_vpc_security_group_ingress_rule" "ingress_http" {
  security_group_id = aws_default_security_group.main.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
}

## VPC -> インターネット: すべて許可
resource "aws_vpc_security_group_egress_rule" "egress_all" {
  security_group_id = aws_default_security_group.main.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # 全てのポート
}
