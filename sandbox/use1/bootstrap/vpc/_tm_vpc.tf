// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

resource "aws_vpc" "main" {
  assign_generated_ipv6_cidr_block = true
  cidr_block                       = "10.0.0.0/16"
  enable_dns_hostnames             = true
  enable_dns_support               = true
  instance_tenancy                 = "default"
  tags = {
    "Name" = "jadegproj-vpc"
  }
}
resource "aws_subnet" "public" {
  assign_ipv6_address_on_creation = true
  availability_zone               = data.aws_availability_zones.available.names[count.index]
  cidr_block = [
    "10.0.0.0/20",
    "10.0.16.0/20",
    "10.0.32.0/20",
  ][count.index]
  count                   = 3
  ipv6_cidr_block         = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, count.index)
  map_public_ip_on_launch = true
  tags = {
    "Name" = "jadegproj-public-${data.aws_availability_zones.available.names[count.index]}"
  }
  vpc_id = aws_vpc.main.id
}
resource "aws_route_table" "public" {
  tags = {
    "Name" = "jadegproj-public-route-table"
  }
  vpc_id = aws_vpc.main.id
}
resource "aws_internet_gateway" "gw" {
  tags = {
    Name = "jadegproj-internet-gateway"
  }
  vpc_id = aws_vpc.main.id
}
resource "aws_route" "public_internet_access" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
  route_table_id         = aws_route_table.public.id
}
resource "aws_route_table_association" "public" {
  count          = 3
  route_table_id = aws_route_table.public.id
  subnet_id      = element(aws_subnet.public[*].id, count.index)
}
resource "aws_subnet" "private" {
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block = [
    "10.0.48.0/20",
    "10.0.64.0/20",
    "10.0.80.0/20",
  ][count.index]
  count = 3
  tags = {
    "Name" = "jadegproj-private-${data.aws_availability_zones.available.names[count.index]}"
  }
  vpc_id = aws_vpc.main.id
}
resource "aws_route_table" "private" {
  tags = {
    "Name" = "jadegproj-private-route-table"
  }
  vpc_id = aws_vpc.main.id
}
resource "aws_eip" "nat" {
  tags = {
    "Name" = "jadegproj-nat-eip"
  }
}
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  depends_on = [
    aws_eip.nat,
    aws_internet_gateway.gw,
  ]
  subnet_id = aws_subnet.public[0].id
  tags = {
    "Name" = "jadegproj-nat"
  }
}
resource "aws_route" "private_internet_access" {
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
  route_table_id         = aws_route_table.private.id
}
resource "aws_route_table_association" "private" {
  count          = 3
  route_table_id = aws_route_table.private.id
  subnet_id      = element(aws_subnet.private[*].id, count.index)
}
