# EKS Infrastructure Assignment Student ID: L00196923

# Overview
This project creates a complete Amazon EKS (Elastic Kubernetes Service) infrastructure using Terraform, including VPC, subnets, security groups, IAM roles, and worker nodes.

# Student Information
Student ID: L00196923
Projectd: EKS Infrastructure Deployment
Technology Stackd: Terraform, AWS EKS, Kubernetes


# Infrastructure Resources
VPCd: `staging-L00196923-vpc` (10.0.0.0/16)
EKS Clusterd: `staging-demo-L00196923`
Subnetsd: 4 subnets across 2 AZs (2 private, 2 public)
Worker Nodesd: t3.micro instances with auto-scaling (1-10 nodes)
IAM Rolesd: EKS cluster and worker node roles with proper policies

# Security Features
Private subnets for worker nodes
Public subnets for load balancers
Proper IAM roles and policies
Network isolation and security groups

# Deployment Instructions

# Prerequisites
AWS CLI configured with appropriate credentials
Terraform installed (v1.0+)
kubectl installed

# Step 1: Deploy Infrastructure

cd terraform
terraform init
terraform plan
terraform apply -auto-approve

# Step 2: Configure kubectl
aws eks update-kubeconfig --region us-east-1 --name staging-demo-L00196923


# Step 3: Verify Deployment
kubectl get nodes
kubectl cluster-info
kubectl get pods --all-namespaces


# Resource Naming Convention
All resources are prefixed with student ID L00196923:
Cluster: `staging-demo-L00196923`
VPC: `staging-L00196923-vpc`
IAM Roles: `staging-demo-L00196923-eks-cluster`
Policies: `staging-demo-L00196923-AWSLoadBalancerController`



# Key Features Implemented
Multi-AZ VPC with public/private subnets
EKS cluster with API server endpoints
Managed worker node groups
IAM roles with least privilege access
Cluster autoscaler support
AWS Load Balancer Controller support
Pod Identity for service accounts

# Testing Commands
# Check cluster status
kubectl cluster-info

# List all nodes
kubectl get nodes

# Check system pods
kubectl get pods -n kube-system

# Deploy test application
kubectl create deployment nginx --image=nginx
kubectl expose deployment nginx --port=80 --type=LoadBalancer


# Cleanup
To destroy the infrastructure:
cd terraform
terraform destroy -auto-approve