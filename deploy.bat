@echo off
echo Starting Terraform deployment for staging-demo application...

cd terraform

echo "------------------------------------------"
echo Step 1: Initializing Terraform...
terraform init

echo "------------------------------------------"
echo Step 2: Planning deployment...
terraform plan

echo "------------------------------------------"
echo Step 3: Applying infrastructure...
terraform apply -auto-approve

echo "------------------------------------------"
echo Step 4: Getting EKS cluster info...
aws eks update-kubeconfig --region us-east-1 --name staging-demo-L00196923

echo "------------------------------------------"
echo Step 5: Verifying deployment...
kubectl get nodes
kubectl get pods -n staging-demo-app
kubectl get svc -n staging-demo-app
kubectl get ingress -n staging-demo-app

echo "------------------------------------------"
echo Deployment completed!

pause