# Provider information
provider "aws" {
  version = "~> 2.0"
  profile                 = var.profile
  shared_credentials_file = var.credentials
  region                  = var.region
}
# Create VPC
resource "aws_vpc" "My_VPC" {
  cidr_block           = var.vpcCIDRblock
  instance_tenancy     = var.instanceTenancy
  enable_dns_support   = var.dnsSupport
  enable_dns_hostnames = var.dnsHostNames
tags = {
    Name = "TF-VPC"
}
}
# create Subnet
resource "aws_subnet" "My_VPC_Subnet" {
  vpc_id                  = aws_vpc.My_VPC.id
  cidr_block              = var.subnetCIDRblock
  map_public_ip_on_launch = var.mapPublicIP
  availability_zone       = var.availabilityZone
tags = {
   Name = "TF-VPC Subnet"
}
}
# Create the Security Group
resource "aws_security_group" "My_VPC_Security_Group" {
  vpc_id       = aws_vpc.My_VPC.id
  name         = "TF-VPC Security Group"
  description  = "TF-VPC Security Group"

  # allow inbound traffic on Port 22
  ingress {
    cidr_blocks = var.ingressCIDRblock
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
tags = {
   Name = "TF-VPC Security Group"
   Description = "TF-VPC Security Group"
}
}
# create NACL
resource "aws_network_acl" "My_VPC_Security_ACL" {
  vpc_id = aws_vpc.My_VPC.id
  subnet_ids = [ aws_subnet.My_VPC_Subnet.id ]
# allow inbound traffic on port 22
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.destinationCIDRblock
    from_port  = 22
    to_port    = 22
  }

  # allow outbound traffic on port 22
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.destinationCIDRblock
    from_port  = 22
    to_port    = 22
  }

tags = {
    Name = "TF-VPC ACL"
}
}
# Create IG
resource "aws_internet_gateway" "My_VPC_GW" {
 vpc_id = aws_vpc.My_VPC.id
 tags = {
        Name = "TF-VPC Internet Gateway"
}
}
# Create Route Table
resource "aws_route_table" "My_VPC_route_table" {
 vpc_id = aws_vpc.My_VPC.id
 tags = {
        Name = "TF-VPC Route Table"
}
}
# Create Internet Access
resource "aws_route" "My_VPC_internet_access" {
  route_table_id         = aws_route_table.My_VPC_route_table.id
  destination_cidr_block = var.destinationCIDRblock
  gateway_id             = aws_internet_gateway.My_VPC_GW.id
}
# Attach route table to subnet
resource "aws_route_table_association" "My_VPC_association" {
  subnet_id      = aws_subnet.My_VPC_Subnet.id
  route_table_id = aws_route_table.My_VPC_route_table.id
}
# Create AWS EC2 instance
resource "aws_instance" "My_EC2_Instance" {
  ami = var.amiid
  instance_type = var.instance_type
  security_groups = [aws_security_group.My_VPC_Security_Group.id]
  key_name = var.keyname
  subnet_id = aws_subnet.My_VPC_Subnet.id
  tags = {
    Name = "TF-EC2 instance"
  }
}
