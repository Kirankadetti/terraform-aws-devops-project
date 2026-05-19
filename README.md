# Terraform AWS DevOps Project

## Secure Cloud Infrastructure Automation using Terraform

This project demonstrates Infrastructure as Code (IaC) and cloud automation using Terraform on AWS. The infrastructure includes networking, compute, storage, IAM configuration, and monitoring services following DevOps best practices.

---

## Features

- Automated AWS infrastructure provisioning using Terraform
- Configured secure VPC networking and security groups
- Deployed EC2 instance with IAM roles and permissions
- Created S3 bucket for cloud storage
- Implemented CloudWatch monitoring and CPU utilization alarms
- Modular and reusable Terraform configuration files
- Infrastructure lifecycle management using `terraform apply` and `terraform destroy`

---

## AWS Services Used

- EC2
- VPC
- IAM
- S3
- CloudWatch
- Security Groups
- Internet Gateway
- Route Tables

---

## Project Structure

terraform-aws-devops-project/

├── provider.tf  
├── main.tf  
├── variables.tf  
├── outputs.tf  
├── iam.tf  
├── s3.tf  
├── cloudwatch.tf  
└── .gitignore  

---

## Terraform Commands Used

### Initialize Terraform

```bash
terraform init

Validate Configuration:
  terraform validate

Preview Infrastructure Changes:
  terraform plan

Deploy Infrastructure:
  terraform apply

Destroy Infrastructure:
  terraform destroy

DevOps Concepts Demonstrated:--
Infrastructure as Code (IaC)
Cloud Infrastructure Automation
AWS Resource Provisioning
Infrastructure Monitoring
Secure Cloud Networking
Terraform State Management
Infrastructure Lifecycle Management

Tech Stack:-
Terraform, AWS, EC2, VPC, IAM, S3, CloudWatch, Infrastructure as Code (IaC), DevOps, Cloud Automation

Author:-
Kiran Kadetti
Aspiring DevOps and Cloud Engineer
