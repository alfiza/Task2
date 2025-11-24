resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"  # 65,536 IPs

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${local.env}-${local.student_id}-vpc"
  }
}