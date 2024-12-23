# AWS VPC with Terraform

This Terraform configuration creates an AWS infrastructure that includes a Virtual Private Cloud (VPC), public and private subnets, an EKS cluster, security groups, and managed EC2 instances. It enables secure and scalable deployment for applications requiring Kubernetes and other cloud resources.

---

## **Changes Made**

- Added an EKS cluster and managed node groups for Kubernetes workloads.
- Implemented private subnets for secure resources like worker nodes and databases.
- Adjusted security groups to allow cluster communication and internet access where needed.
- Split Terraform configuration into modules for easier maintenance.
- Included tags for resource identification and organization.
- Updated the configuration for NAT Gateway and Internet Gateway to handle routing appropriately.

**Date of Update**: December 23, 2024

---

## **Resources Created**

### **VPC**

- **CIDR block**: `10.0.0.0/16`
- DNS support and DNS hostnames enabled.

### **Subnets**

- **Public Subnets**:
  - `10.0.1.0/24` in `eu-central-1a`
  - `10.0.2.0/24` in `eu-central-1b`
- **Private Subnets**:
  - `10.0.101.0/24` in `eu-central-1a`
  - `10.0.102.0/24` in `eu-central-1b`

### **Internet Gateway and NAT Gateway**

- **Internet Gateway**:
  - Attached to the VPC for public internet access.
- **NAT Gateway**:
  - Enables internet access for resources in private subnets.

### **Route Tables**

- **Public Route Table**:
  - Routes traffic to the Internet Gateway for public subnets.
- **Private Route Table**:
  - Routes traffic through the NAT Gateway for private subnets.

### **EKS Cluster**

- **Cluster Name**: `social-media-scraper`
- **Cluster Version**: `1.26`
- Deployed with managed node groups.
- Nodes are deployed in private subnets for security.
- IAM roles and policies configured for cluster and node group operations.

### **Security Groups**

- **EKS Cluster Security Group**:
  - Allows cluster control plane communication.
- **Node Group Security Group**:
  - Allows communication between worker nodes and the cluster.
  - Outbound internet access for pulling container images.
- **SSH Security Group**:
  - Allows inbound SSH (port 22) from all IPs for instances.

### **EC2 Instances**

- **AMI**: `ami-0a628e1e89aaedf80` (Ubuntu-based image, replace with the desired AMI ID as needed).
- **Instances**:
  - `vm_1a`: Deployed in `public_1a` subnet (AZ: `eu-central-1a`).
  - `vm_1b`: Deployed in `public_1b` subnet (AZ: `eu-central-1b`).
- **User Data**:
  - Updates and installs basic packages on instance startup.

---

## **Usage**

1. **Prepare the Environment**:

   - Ensure Terraform is installed.
   - Set up your AWS CLI with appropriate credentials.
   - Set the desired AMI ID and SSH key pair in the Terraform configuration.

2. **Apply Configuration**:

   - Initialize Terraform:
     ```bash
     terraform init
     ```
   - Review the plan:
     ```bash
     terraform plan
     ```
   - Apply the configuration:
     ```bash
     terraform apply
     ```

3. **Access Resources**:

   - **EKS Cluster**:
     - Generate the kubeconfig file:
       ```bash
       aws eks update-kubeconfig --region eu-central-1 --name social-media-scraper
       ```
     - Verify access:
       ```bash
       kubectl get nodes
       ```
   - **EC2 Instances**:
     - Use the assigned public IPs for the EC2 instances.
     - SSH into the instances:
       ```bash
       ssh -i /path/to/your-key.pem ubuntu@<public-ip>
       ```

---

## **Best Practices**

- Ensure private subnets are used for sensitive resources (e.g., databases, worker nodes).
- Regularly update and audit IAM roles and policies to maintain security.
- Use Terraform remote backend for state file management.
- Monitor resources using AWS CloudWatch and other monitoring tools.

---

## **Next Steps**

- Integrate monitoring tools like Prometheus and Grafana for Kubernetes workloads.
- Configure CI/CD pipelines for automated deployment of applications.
- Optimize security group rules to minimize open ports and CIDR ranges.

