resource "aws_security_group" "alb_sg" {
  name        = "${local.env}-${local.student_id}-alb-sg"
  description = "Security group for ALB to receive traffic from the internet"
  vpc_id      = aws_vpc.main.id

  # Allow public HTTP traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic (required for ALB to talk to nodes)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.env}-${local.student_id}-alb-sg"
  }
}

resource "aws_security_group" "nodes_sg" {
  name        = "${local.env}-${local.student_id}-nodes-sg"
  description = "Security group for worker nodes (only ALB can reach nodes)"
  vpc_id      = aws_vpc.main.id

  # Only ALB → Nodes traffic allowed
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  # Allow outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.env}-${local.student_id}-nodes-sg"
  }
}
