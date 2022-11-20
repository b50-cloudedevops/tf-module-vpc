resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  route {
    cidr_block =  var.DEFAULT_VPC_CIDR
    vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  }

   tags = {
    Name = "${var.ENV}-pub-route-table"
  }
}
#Attaches public route-table to public subnets
resource "aws_route_table_association" "public-rt-association" {
    count = length(aws_subnet.public.*.id)
    subnet_id = element(aws_subnet.public.*.id, count.index)
    route_table_id = aws_route_table.public-rt.id
}

#created private route table
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block =  var.DEFAULT_VPC_CIDR
    vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  }

   tags = {
    Name = "${var.ENV}-prv-route-table"
  }
}
resource "aws_route_table_association" "private-rt-association" {
    count = length(aws_subnet.private.*.id)
    subnet_id = element(aws_subnet.private.*.id, count.index)
    route_table_id = aws_route_table.private-rt.id
}

#add route on the default vpcs public subnet route table
resource "aws_route" "r" {
  route_table_id            = var.DEFAULT_VPC_RT
  destination_cidr_block    = var.DEFAULT_VPC_CIDR
  vpc_peering_connection_id = aws_vpc_peering_connection.peer
  depends_on                = [aws_route_table.testing]
}
