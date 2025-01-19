# FastAPI ML Model Deployment on Amazon EKS with Terraform and Jenkins

This repository provides a template of deploying a FastAPI machine learning model on **Amazon EKS** using **Terraform** for infrastructure management and **Jenkins** for the CI/CD pipeline.

## Overview

- **Infrastructure**: Provision Amazon EKS (Elastic Kubernetes Service) using Terraform for running a Kubernetes cluster.
- **CI/CD Pipeline**: Use Jenkins for automating the deployment and management of FastAPI applications.
- **Application**: FastAPI serves a machine learning model (e.g., image classification, regression, or NLP model) via REST APIs.

### Tools Used

- **Terraform**: Infrastructure as Code (IaC) tool for automating the provisioning of AWS resources.
- **Amazon EKS**: Managed Kubernetes service on AWS.
- **Jenkins**: CI/CD tool for automating deployment workflows.
- **FastAPI**: Python web framework for serving the machine learning model.
- **Docker**: For containerizing the FastAPI application.
- **Kubernetes**: For managing and orchestrating containers on the EKS cluster.

## Prerequisites

Before starting, ensure you have the following set up:

- AWS CLI installed and configured with the appropriate permissions.
- Terraform installed (`v1.x` or higher).
- Jenkins server set up. (Please reach me out for how to setup Jenkins with terraform if you need any help)
- Docker installed.
- kubectl installed for interacting with the Kubernetes cluster.

## Architecture

1. **Terraform** provisions the following AWS infrastructure: 
    - An EKS cluster.
    - Node groups (EC2 instances) for running the Kubernetes pods.
    - VPC, subnets, and security groups. (Used existing VPC in this tutorial)
    - S3 buckets for storing Terraform states.

2. **Jenkins Pipeline** is used to:
    - Build and push Docker images of the FastAPI app.
    - Deploy the Dockerized FastAPI app on the EKS cluster using Kubernetes manifests.
    
3. **FastAPI Application** exposes machine learning APIs for model inference.

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/Taha-Cakir/ml-deployment-with-terraform-eks-jenkins.git
cd ml-deployment-with-terraform-eks-jenkins
```

### Build Infra via Local (Please fill the AWS related parameters)
```
cd terraform
terraform init
terraform apply -auto-approve
```
### Build Infra with Jenkins (Please fill the AWS related parameters according to your Account)
- Set up your AWS credentials and store it in Jenkins if you didn't already
- Connect this forked repository to Jenkins and push it. Jenkins will get the groovy Jenkinsfile for CICD automation.

**Run the pipeline, and Jenkins will:**

- Build the Docker image for your FastAPI ML model.
- Push the Docker image to ECR.
- Deploy the FastAPI app on EKS using Kubernetes manifests.

