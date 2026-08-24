### Calculator History App — AWS EKS + Terraform + Kubernetes + CI/CD ###

A production-style containerized calculator application deployed on **Amazon EKS** using **Terraform**, **Kubernetes**, **Helm**, and
**CI/CD automation**.

This project demonstrates practical cloud infrastructure and DevOps skills including Infrastructure as Code, containerization, Kubernetes orchestration, 
persistent storage, automated deployments, and AWS networking.

-----

## 🏗️ Architecture


                         GitHub
                            │
                            │ Push
                            ▼
                    CI/CD Pipeline
                            │
                            │ Build & Deploy
                            ▼
                    Docker Images
                            │
                            ▼
                    Amazon ECR
                            │
                            ▼
              ┌─────────────────────────┐
              │       Amazon EKS        │
              │                         │
              │  ┌───────────────────┐  │
              │  │ Ingress NGINX      │  │
              │  │ LoadBalancer       │  │
              │  └─────────┬─────────┘  │
              │            │             │
              │     ┌──────┴──────┐      │
              │     ▼             ▼      │
              │  Frontend       Backend  │
              │     │             │      │
              │     └──────┬──────┘      │
              │            ▼             │
              │          MySQL           │
              │       Persistent         │
              │        Storage           │
              └─────────────────────────┘
                            │
                            ▼
                       AWS VPC
                  Public Subnets



## 🚀 Technology Stack

*Cloud*
 - AWS
 - Amazon EKS
 - Amazon ECR
 - Amazon VPC
 - EC2
 - IAM
 - Elastic Load Balancing
*Infrastructure as Code*
 - Terraform
 - Terraform AWS Provider
*Containers*
 - Docker
 - Amazon ECR
*Kubernetes*
 - Kubernetes
 - Amazon EKS
 - Helm
 - NGINX Ingress Controller
 - Kubernetes Services
 - Kubernetes Deployments
 - StatefulSet
 - Persistent Storage
*CI/CD*
 - GitHub Actions
 - Automated Docker image builds
 - Automated deployment using Helm
*Application*
 - Frontend: HTML / CSS / JavaScript
 - Backend: Python
 - Database: MySQL


## ☁️ AWS Infrastructure

The infrastructure is provisioned using Terraform.

Terraform creates and manages:

 - VPC
 - Public subnets
 - Internet Gateway
 - Route Table
 - Route Table Associations
 - EKS Cluster
 - EKS Managed Node Group
 - IAM roles
 - IAM policy attachments
 - Security Groups
 - EKS networking configuration

*Current EKS configuration*

 Cluster:
 calculator-eks

 Region:
 ap-southeast-1

 Node Group:
 calculator-app-ng

 Instance Type:
 t3.small

 Capacity:
 ON_DEMAND

 AMI:
 AL2023_x86_64_STANDARD

 Kubernetes:
 v1.36.2

 Node Count:
 1

 Node Label:
 workload=application

The infrastructure is intentionally kept small to reduce AWS cost while providing a realistic Kubernetes production-style environment.


## 🏗️ Terraform Structure

	terraform/
	└── calculator-production/
	    ├── eks.tf
	    ├── eks-nodes.tf
	    ├── iam.tf
	    ├── locals.tf
	    ├── network.tf
	    ├── outputs.tf
	    ├── providers.tf
	    ├── security.tf
	    ├── variables.tf
	    ├── versions.tf
	    └── .terraform.lock.hcl

Terraform state files, provider binaries, credentials, variables, and backups are intentionally excluded from Git.


## ☸️ Kubernetes Architecture

The application runs inside the calculator namespace.

*calculator namespace*

	frontend Deployment
	        │
	        ▼
	frontend Service
	NodePort :30080
	        │
	        ▼
	Frontend Pods

	backend Deployment
	        │
	        ▼
	backend Service
	ClusterIP :5000
	        │
	        ▼
	Backend Pod
	        │
	        ▼
	MySQL Service
	        │
	        ▼
	MySQL StatefulSet
	        │
	        ▼
	Persistent Volume


The cluster also contains:

 - NGINX Ingress Controller
 - CoreDNS
 - AWS VPC CNI
 - EBS CSI Driver
 - Metrics Server
 - EKS Pod Identity Agent
 - kube-proxy


## 💾 Persistent MySQL Storage

MySQL uses Kubernetes persistent storage rather than ephemeral container storage.

This ensures database data can survive MySQL pod recreation.

The project uses:

	MySQL StatefulSet
	        │
	        ▼
	PersistentVolumeClaim
	        │
	        ▼
	AWS EBS-backed storage

This demonstrates practical Kubernetes stateful workload management.


## 🌐 Ingress

The application uses the NGINX Ingress Controller.

Traffic flow:

	Internet
	   │
	   ▼
	AWS Load Balancer
	   │
	   ▼
	NGINX Ingress Controller
	   │
	   ▼
	Frontend Service
	   │
	   ▼
	Frontend Pod

The backend remains an internal Kubernetes ClusterIP service.



## 🔄 CI/CD Pipeline

The project includes automated CI/CD.

Typical deployment flow:


	Developer
	    │
	    ▼
	Git Push
	    │
	    ▼
	GitHub
	    │
	    ▼
	GitHub Actions
	    │
	    ├── Build frontend/backend images
	    │
	    ├── Push images to Amazon ECR
	    │
	    └── Deploy using Helm
	             │
	             ▼
	          Amazon EKS

This removes the need to manually build and deploy application containers.


## 📦 Helm

The application is packaged using a Helm chart.

	calculator-chart/
	├── Chart.yaml
	├── values.yaml
	└── ...

Helm is used to manage Kubernetes application deployment and configuration.


## 🔐 Security & Configuration

Sensitive information is not committed to Git.

The .gitignore excludes:

 .env
 *.tfstate
 *.tfstate.*
 terraform.tfvars
 terraform.tfvars.json
 .terraform/

AWS credentials are never stored inside the Terraform source code.

Application configuration is provided through environment variables and Kubernetes configuration.


## 🧪 Validation

Infrastructure was validated using Terraform:

 terraform plan

Result:

 No changes. Your infrastructure matches the configuration.

EKS node health:

 kubectl get nodes

Example:

 NAME                                            STATUS   ROLES    VERSION
 ip-10-20-1-64.ap-southeast-1.compute.internal   Ready    <none>   v1.36.2-eks-b3f9404

Application workloads:

 kubectl get pods -n calculator

Example:

 backend-bfcdd6db4-56966    1/1   Running
 frontend-df585b755-ktdx2   1/1   Running
 mysql-0                    1/1   Running


## 🖥️ Local Application Testing

The frontend can be tested through Kubernetes port forwarding:

 kubectl port-forward svc/frontend 8080:80 -n calculator

Then open:

 http://localhost:8080

This was used to verify that the application is running successfully inside EKS.


## 🧰 Useful Commands

*Terraform*
 cd terraform/calculator-production

 terraform init
 terraform validate
 terraform plan
 terraform apply

*Kubernetes*
 kubectl get nodes
 kubectl get pods -A
 kubectl get pods -n calculator
 kubectl get svc -n calculator
 kubectl get pods -n ingress-nginx
 kubectl get svc -n ingress-nginx

*Application testing*
kubectl port-forward svc/frontend 8080:80 -n calculator


## 📁 Repository Structure
	
	calculator-history-app/
	│
	├── backend/
	│   ├── Dockerfile
	│   ├── app.py
	│   └── requirements.txt
	│
	├── frontend/
	│   ├── index.html
	│   ├── script.js
	│   └── style.css
	│
	├── mysql/
	│   └── init.sql
	│
	├── nginx/
	│   ├── Dockerfile
	│   └── default.conf
	│
	├── calculator-chart/
	│   ├── Chart.yaml
	│   └── values.yaml
	│
	├── terraform/
	│   └── calculator-production/
	│       ├── eks.tf
	│       ├── eks-nodes.tf
	│       ├── iam.tf
	│       ├── locals.tf
	│       ├── network.tf
	│       ├── outputs.tf
	│       ├── providers.tf
	│       ├── security.tf
	│       ├── variables.tf
	│       └── versions.tf
	│
	├── docker-compose.yml
	└── README.md


## 🎯 DevOps Skills Demonstrated

This project demonstrates practical experience with:

 - Linux
 - Git & GitHub
 - Docker
 - Docker image management
 - Amazon ECR
 - AWS VPC
 - AWS IAM
 - Amazon EKS
 - EC2
 - Kubernetes
 - Kubernetes networking
 - Kubernetes Services
 - Kubernetes Deployments
 - StatefulSets
 - Persistent Volumes
 - Helm
 - NGINX Ingress
 - Terraform
 - Infrastructure as Code
 - GitHub Actions
 - CI/CD
 - Application troubleshooting
 - Production-style deployment
 - Cloud infrastructure validation


## 💼 Project Highlights

*Infrastructure as Code*

AWS infrastructure is reproducible using Terraform instead of manually creating resources through the AWS Console.

*Kubernetes Deployment*

The application is deployed to a real Amazon EKS cluster rather than only running locally with Docker Compose.

*Persistent Database*

MySQL uses persistent Kubernetes storage backed by AWS infrastructure.

*Automated Delivery*

GitHub Actions handles application build and deployment workflows.

*Production-style Architecture*

The project separates:

 Frontend
 Backend
 Database
 Ingress
 Infrastructure
 CI/CD

into independently managed components.


## Infrastructure Drift Management

Existing AWS EKS resources were imported into Terraform state and reconciled with the Terraform configuration.

The final validation produced:

  No changes. Your infrastructure matches the configuration.


## 📌 What I Built

I designed and deployed a containerized full-stack application on AWS EKS and automated its infrastructure and application delivery.

The project covers the complete path:

		Application
		    ↓
		  Docker
		    ↓
		   ECR
		    ↓
	        GitHub Actions
    		    ↓
		   Helm
    		    ↓
		Kubernetes
		    ↓
		Amazon EKS
		    ↓
	AWS Infrastructure managed by Terraform


## 👨‍💻 Author

** Haseeb Amin **

Energy & Environmental Engineer transitioning into Cloud / DevOps / Platform / System Reliability / AIOps / MLOps / Infrastructure Engineering.

This project focuses on demonstrating practical infrastructure engineering capabilities through a complete AWS + Kubernetes deployment.

