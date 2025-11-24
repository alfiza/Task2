locals {
  student_id  = "L00196923"   # Student ID 
  env         = "staging"     # Environment name
  region      = "us-east-1"   # AWS region
  zone1       = "us-east-1a"  # First location
  zone2       = "us-east-1b"  # Second backup location 
  eks_name    = "demo"        # create  cluster
  eks_version = "1.34"        # Kubernetes version
}