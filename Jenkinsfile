#!/usr/bin/env groovy
pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "<AWS_REGION>"
    }
    stages {
        stage("Build and Push Docker Image to ECR'") {
            steps {
                script {
                    dir('ml-model-service/docker') {
                        sh './build-ecr.sh'
                    }
                }
            }
        }
        stage("Creating an EKS Cluster") {
            steps {
                script {
                    dir('terraform') {
                        sh "terraform init"
                        sh "terraform apply -auto-approve"
                    }
                }
            }
        }
        stage("Deploy to EKS") {
            steps {
                script {
                    dir('ml-model-service') {
                        sh "aws eks update-kubeconfig --name test-eks-cluster"
                        sh "kubectl apply -f ml-model-deployment.yml"
                        sh "kubectl apply -f ml-service.yml"
                    }
                }
            }
        }
    }
}