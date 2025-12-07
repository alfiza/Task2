# Permission role for EKS to manage the cluster
resource "aws_iam_role" "eks" {
  name = "${local.env}-${local.eks_name}-${local.student_id}-eks-cluster"

  # Allow EKS service to use this role
  assume_role_policy = <<POLICY
    {
        "Version" : "2012-10-17",
        "Statement" : [
            {
                "Effect": "Allow",
                "Action": "sts:AssumeRole",
                "Principal": {
                    "Service": "eks.amazonaws.com"
                }                 
            }
        ] 
    }
POLICY
}

resource "aws_iam_role_policy_attachment" "eks" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks.name
}

# Main Kubernetes cluster 
resource "aws_eks_cluster" "eks" {
  name     = "${local.env}-${local.eks_name}-${local.student_id}"  
  version  = local.eks_version
  role_arn = aws_iam_role.eks.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.private_zone1.id,
      aws_subnet.private_zone2.id
    ]

    security_group_ids = [
      aws_security_group.nodes_sg.id
    ]
  }

  
  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

  depends_on = [aws_iam_role_policy_attachment.eks]
}

