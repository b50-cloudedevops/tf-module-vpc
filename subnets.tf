resource "aws_subnet" "pub-main1" {
    vpc_id = aws_vpc.main.id
    count = length(var.PUBLIC_SUBNET_CIDR)
    cidr_block = element(var.PUBLIC_SUBNET_CIDR, count.index)
    availability_zone = element(var.AZ, count.index)
    tags = {
        Name = "${var.ENV}-${element(var.AZ, count.index)}"
    }
}