############################
# HUB VPC
############################
resource "aws_vpc" "hub_vpc" {
cidr_block = "10.0.0.0/16"
tags = { Name = "Hub-VPC" }
}


resource "aws_internet_gateway" "hub_igw" {
vpc_id = aws_vpc.hub_vpc.id
tags = { Name = "Hub-IGW" }
}


resource "aws_subnet" "hub_public_subnet" {
vpc_id = aws_vpc.hub_vpc.id
cidr_block = "10.0.1.0/24"
map_public_ip_on_launch = true
availability_zone = "ap-south-1a"
tags = { Name = "Hub-Public-Subnet" }
}


resource "aws_subnet" "hub_private_subnet" {
vpc_id = aws_vpc.hub_vpc.id
cidr_block = "10.0.2.0/24"
availability_zone = "ap-south-1a"
tags = { Name = "Hub-Private-Subnet" }
}


resource "aws_route_table" "hub_public_rt" {
vpc_id = aws_vpc.hub_vpc.id


route {
cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.hub_igw.id
}


tags = { Name = "Hub-Public-RT" }
}


resource "aws_route_table_association" "hub_public_assoc" {
subnet_id = aws_subnet.hub_public_subnet.id
route_table_id = aws_route_table.hub_public_rt.id
}

############################
# SPOKE A VPC
############################
resource "aws_vpc" "spoke_a_vpc" {
cidr_block = "10.1.0.0/16"
tags = { Name = "Spoke-A-VPC" }
}


resource "aws_subnet" "spoke_a_subnet" {
vpc_id = aws_vpc.spoke_a_vpc.id
cidr_block = "10.1.1.0/24"
availability_zone = "ap-south-1a"
tags = { Name = "Spoke-A-Subnet" }
}


resource "aws_route_table" "spoke_a_rt" {
vpc_id = aws_vpc.spoke_a_vpc.id
tags = { Name = "Spoke-A-RT" }
}


resource "aws_route_table_association" "spoke_a_assoc" {
subnet_id = aws_subnet.spoke_a_subnet.id
route_table_id = aws_route_table.spoke_a_rt.id
}

############################
# SPOKE B VPC
############################
resource "aws_vpc" "spoke_b_vpc" {
cidr_block = "10.2.0.0/16"
tags = { Name = "Spoke-B-VPC" }
}


resource "aws_subnet" "spoke_b_subnet" {
vpc_id = aws_vpc.spoke_b_vpc.id
cidr_block = "10.2.1.0/24"
availability_zone = "ap-south-1a"
tags = { Name = "Spoke-B-Subnet" }
}


resource "aws_route_table" "spoke_b_rt" {
vpc_id = aws_vpc.spoke_b_vpc.id
tags = { Name = "Spoke-B-RT" }
}


resource "aws_route_table_association" "spoke_b_assoc" {
subnet_id = aws_subnet.spoke_b_subnet.id
route_table_id = aws_route_table.spoke_b_rt.id
}

############################
# VPC PEERING
############################
resource "aws_vpc_peering_connection" "hub_spoke_a" {
vpc_id = aws_vpc.hub_vpc.id
peer_vpc_id = aws_vpc.spoke_a_vpc.id
auto_accept = true
tags = { Name = "Hub-Spoke-A" }
}


resource "aws_vpc_peering_connection" "hub_spoke_b" {
vpc_id = aws_vpc.hub_vpc.id
peer_vpc_id = aws_vpc.spoke_b_vpc.id
auto_accept = true
tags = { Name = "Hub-Spoke-B" }
}

############################
# ROUTES
############################
resource "aws_route" "hub_to_spoke_a" {
route_table_id = aws_route_table.hub_public_rt.id
destination_cidr_block = "10.1.0.0/16"
vpc_peering_connection_id = aws_vpc_peering_connection.hub_spoke_a.id
}


resource "aws_route" "hub_to_spoke_b" {
route_table_id = aws_route_table.hub_public_rt.id
destination_cidr_block = "10.2.0.0/16"
vpc_peering_connection_id = aws_vpc_peering_connection.hub_spoke_b.id
}


resource "aws_route" "spoke_a_to_hub" {
route_table_id = aws_route_table.spoke_a_rt.id
destination_cidr_block = "10.0.0.0/16"
vpc_peering_connection_id = aws_vpc_peering_connection.hub_spoke_a.id
}


resource "aws_route" "spoke_b_to_hub" {
route_table_id = aws_route_table.spoke_b_rt.id
destination_cidr_block = "10.0.0.0/16"
vpc_peering_connection_id = aws_vpc_peering_connection.hub_spoke_b.id
}