# Private subnet - secure area for worker nodes (no internet access)
resource "aws_subnet" "private_zone1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/19"  # 8,192 IPs
  availability_zone = local.zone1

  tags = {
    "Name"                                                        = "${local.env}-private-${local.zone1}"
    "kubernetes.io/role/internal-elb"                             = "1"      # for load balancers
    "kubernetes.io/cluster/${local.env}-${local.eks_name}-${local.student_id}" = "owned"  # for cluster
  }
}

resource "aws_subnet" "private_zone2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.32.0/19"
  availability_zone = local.zone2

  tags = {
    "Name"                                                        = "${local.env}-private-${local.zone2}"
    "kubernetes.io/role/internal-elb"                             = "1"
    "kubernetes.io/cluster/${local.env}-${local.eks_name}-${local.student_id}" = "owned"
  }
}

# Public subnet
resource "aws_subnet" "public_zone1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.64.0/19"  # 8,192 IPs
  availability_zone       = local.zone1
  map_public_ip_on_launch = true

  tags = {
    "Name"                                                        = "${local.env}-public-${local.zone1}"
    "kubernetes.io/role/elb"                                      = "1"      # For public load balancers
    "kubernetes.io/cluster/${local.env}-${local.eks_name}-${local.student_id}" = "owned"  # Belongs to our cluster
  }
}


resource "aws_subnet" "public_zone2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.96.0/19"
  availability_zone       = local.zone2
  map_public_ip_on_launch = true

  tags = {
    "Name"                                                        = "${local.env}-public-${local.zone2}"
    "kubernetes.io/role/elb"                                      = "1"
    "kubernetes.io/cluster/${local.env}-${local.eks_name}-${local.student_id}" = "owned"
  }
} 