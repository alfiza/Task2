resource "aws_iam_role" "aws_lbc" {
  name = "${aws_eks_cluster.eks.name}-aws-lbc"
  # Use a trust policy that references the OIDC provider
  assume_role_policy = file("${path.root}/iam/iam_trust_pod_identity.json")
}

resource "aws_iam_policy" "aws_lbc" {
  name   = "${aws_eks_cluster.eks.name}-AWSLoadBalancerController"

  # this json should be the official IAM policy for AWS Load Balancer Controler
  policy = file("${path.root}/iam/AWSLoadBalancerController.json")
}

resource "aws_iam_role_policy_attachment" "aws_lbc" {
    policy_arn = aws_iam_policy.aws_lbc.arn
    role = aws_iam_role.aws_lbc.name
    # attaches the required LB controller permissions to the role
}

resource "aws_eks_pod_identity_association" "aws_lbc" {
    cluster_name = aws_eks_cluster.eks.name
    namespace = "kube-system"
    service_account = "aws-load-balancer-controller"
    role_arn = aws_iam_role.aws_lbc.arn
    
   # link the IAM role with the Kubernetes Service Account
}
