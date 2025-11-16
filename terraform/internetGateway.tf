resource "aws_internet_gateway" "internetGateway" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "${local.env}-internetGateway"
    }
}