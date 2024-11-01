# Java Web Application CI/CD Pipeline with GitHub Actions

This repository contains a Java web application with a CI/CD pipeline configured using GitHub Actions. The pipeline automates:
1. **Building and testing** the application.
2. **Pushing** a Docker image to Amazon ECR.
3. **Provisioning infrastructure** (EKS cluster, VPC) on AWS with Terraform.
4. **Deploying** the Docker image to an EKS cluster.

---

## Prerequisites
Ensure the following prerequisites are met before setting up the pipeline.

### 1. Software Requirements
- **Docker**: To build and run Docker containers locally.
- **Terraform**: To provision infrastructure on AWS.
- **AWS CLI**: To interact with AWS services, set up your EKS cluster, and manage resources.

### 2. AWS Requirements
- An **AWS account** and an IAM user with necessary permissions:
  - ECR: To push Docker images.
  - EKS: To provision and manage clusters.
  - VPC: To create and configure networking components.
- **AWS IAM Permissions** required for the CI/CD pipeline:
  - `AmazonEKSClusterPolicy`
  - `AmazonEC2ContainerRegistryFullAccess`
  - `AmazonVPCFullAccess`
  - `IAMFullAccess` (for EKS role creation)

### 3. GitHub Requirements
- A GitHub repository with the following **secrets** configured for the pipeline:
  - **`AWS_ACCESS_KEY_ID`**: IAM user access key.
  - **`AWS_SECRET_ACCESS_KEY`**: IAM user secret access key.
  - **`AWS_ACCOUNT_ID`**: AWS account ID (for ECR).
  - **`AWS_REGION`**: AWS region for deploying infrastructure and the Docker image.
  - **`EKS_CLUSTER_NAME`**: Name of the EKS cluster to deploy to.

---

## Setting Up the CI/CD Pipeline

### 1. Fork or Clone the Repository
Start by forking or cloning this repository to your GitHub account.

### 2. Configure GitHub Secrets
In your GitHub repository, go to **Settings > Secrets and variables > Actions** and add the following secrets:

- **`AWS_ACCESS_KEY_ID`**: Your AWS IAM user’s access key ID.
- **`AWS_SECRET_ACCESS_KEY`**: Your AWS IAM user’s secret access key.
- **`AWS_ACCOUNT_ID`**: Your AWS account ID (e.g., `123456789012`).
- **`AWS_REGION`**: The AWS region for your resources (e.g., `us-west-2`).
- **`EKS_CLUSTER_NAME`**: The name of your EKS cluster (e.g., `my-java-app-cluster`).

### 3. AWS Credentials Configuration for Local Development (Optional)
To test locally, configure AWS credentials on your machine. Run:

```bash
aws configure
```

Follow the prompts to set up your `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, and `AWS_REGION`.

---

## GitHub Actions Workflow Explanation

### CI Workflow: `.github/workflows/ci.yaml`
This workflow is triggered on any push or pull request to the `main` branch. It performs the following actions:
1. **Checks out** the repository.
2. **Builds** the Java application with Maven.
3. **Builds** a Docker image and **pushes** it to Amazon ECR.
4. **Runs tests** on the codebase.

### CD Workflow: `.github/workflows/cd.yaml`
This workflow is triggered on any push to the `main` branch and includes:
1. **Provisioning infrastructure** on AWS using Terraform:
   - A VPC with public and private subnets.
   - An EKS cluster with worker nodes.
2. **Deploying** the application to the EKS cluster using Helm.

### Running the Workflows Locally (Optional)
To run the workflows locally, install [act](https://github.com/nektos/act), a tool for running GitHub Actions locally, and run:

```bash
act push -W .github/workflows/ci.yaml
act push -W .github/workflows/cd.yaml
```

---

## Using the Application in EKS

Once the pipeline completes:
1. Access the application via the configured Ingress URL.
2. Monitor the application and infrastructure through the AWS Console and Kubernetes commands.

### Useful Commands
Use the following commands to interact with the deployed resources:
- **EKS Cluster Access**:
  ```bash
  aws eks update-kubeconfig --name $EKS_CLUSTER_NAME --region $AWS_REGION
  kubectl get nodes
  kubectl get pods
  ```

- **Helm Deployment**:
  ```bash
  helm list
  ```

---

## Troubleshooting

### 1. AWS Errors
Instances failed to join the kubernetes cluster

### 2. Terraform Errors
Check Terraform permissions on the AWS IAM user and verify the AWS region configuration.

---

## Security and Best Practices
- **Secure GitHub Secrets**: Never hard-code AWS credentials; always use GitHub secrets.
- **Restrict IAM Permissions**: Limit permissions to only necessary actions for EKS, ECR, and VPC.

--- 

This setup provides a fully automated CI/CD pipeline for deploying a Java application to AWS EKS with Terraform and Helm. Let us know if you encounter any issues or need further customization!
