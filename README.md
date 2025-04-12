# ACS730 Winter 2025 NBB Final Project

## 🚀 Project Title: Two-Tier Web Application Deployment with Terraform & Ansible

### 👩‍💻 Team Members
- Hemanshi210 (hemanshi210)

---

## 🧾 Project Overview
This project provisions a secure, scalable two-tier web architecture on AWS using Terraform. It automates deployment across `dev`, `staging`, and `prod` environments and configures Webservers and Bastion hosts using Ansible. Images are loaded from a private S3 bucket and served via HTTP.

---

## 🧱 Architecture Summary
- VPC with 4 Public Subnets (Webservers + Bastion Host)
- 2 Private Subnets (for DB and internal VMs)
- NAT Gateway for internet access from Private subnet
- Application Load Balancer (ALB)
- Auto Scaling Group configured
- 6 EC2 Instances:
  - Webserver1 & Webserver3: Created with Terraform & ALB
  - Webserver2: Acts as Bastion Host
  - Webserver4: Configured via Ansible
  - VM5: Private subnet, connects via Bastion and NAT GW (configured with Apache)
  - VM6: Private subnet internal machine
- S3 bucket to store image served on all Webservers

---

## ⚙️ Tools & Technologies
- Terraform (modularized code)
- Ansible (Dynamic + Static Inventory)
- AWS CLI
- GitHub Actions (for Security Scans & Auto-Deploy)
- Trivy & tflint for code scanning

---

## ✅ Pre-requisites
- Create a private **S3 bucket**
- Upload a publicly accessible image or generate
- Store Terraform backend state remotely (S3)
- Configure AWS credentials using `aws configure`

---

## 🛠️ Deployment Instructions
### 🌐 Terraform
1. Clone the repo:
   ```bash
   git clone https://github.com/hemanshi210/acs730-final-project.git
   cd acs730-final-project/envs/dev
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Apply infrastructure:
   ```bash
   terraform apply -auto-approve
   ```

4. Save output values: ALB DNS, EC2 IPs, etc.

---

### 🤖 Ansible (From Control Node / Cloud9)
1. SSH into Bastion Host:
   ```bash
   ssh -i newkey.pem ubuntu@<Bastion-IP>
   ```

2. Run playbooks:
   ```bash
   ansible-playbook -i static_hosts webserver_config.yml
   ```

---

## 🌐 Accessing the Web App
- Access the ALB URL: `http://<alb-dns-name>`
- Image from S3 should render correctly

---

## 🔐 GitHub Actions Setup
- Code scanning on every `push` to `staging`
- PR merge protection enabled for `main` and `prod`
- Auto deployment after merging to `main`

---

## 📊 Traffic Flow Explanation
- Red Flow: User ↔ ALB ↔ Webservers 1 & 3 (HTTP Traffic)
- Blue Flow: SSH to Bastion Host ↔ VM5 & VM6 (via Private Subnet)
- Green Flow:* NAT Gateway ↔ VM5 ↔ Internet (Package download)

---

## ✅ Verification Steps
- Webserver1, Webserver3, and ALB show image from S3 ✅
- SSH to Bastion Host + access Private VMs ✅
- Apache installed & running on VM5 ✅

---

## 📝 Cleanup
To delete infrastructure:
```bash
terraform destroy -auto-approve
```
> Make sure to delete S3 bucket objects manually if versioning is enabled.

---

## 💡 Challenges & Learnings
- Troubleshooting SSH connectivity through Bastion
- Creating Terraform modules for reusability
- Dynamically generating inventory for Ansible
- Using GitHub Actions for secure deployments

---


## 🔗 Resources
- [AWS Docs](https://docs.aws.amazon.com)
- [Terraform Registry](https://registry.terraform.io)
- [Ansible Dynamic Inventory Guide](https://docs.ansible.com)
- [GitHub Actions Docs](https://docs.github.com/actions)

---
