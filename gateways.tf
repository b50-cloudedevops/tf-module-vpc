# creates internet gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
    tags =  {
        Name = "${var.ENV}-igw"
    }
}
# allocates elastic iprovider 
resource "aws_eip" "ngw-eip" {
    vpc = true
}


#created NAT Gateway
resource "aws_nat_gateway" "ngw" {
    allocation_id =  aws_eip.ngw-eip.id 
    subnet_id = aws_subnet.public.*.id[0] 
    tags =  {
        Name = "${var.ENV}-ngw"
    }
    depends_on = [
       aws_internet_gateway.igw
    ]
}