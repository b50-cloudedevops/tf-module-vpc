resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block = "0.0.0.0"
    gateway_id = gateway_id.igw.id
  }

   tags = {
    Name = "${var.ENV}-pub-route-table"
  }
}