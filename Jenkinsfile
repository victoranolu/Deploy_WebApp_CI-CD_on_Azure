#!/usr/bin/env groovy
pipeline {
    agent any
    environment {
       secretEnvVar(key: 'ARM_CLIENT_ID', secretName: {{$secretName}}, secretKey: {{$clientid}}),
       secretEnvVar(key: 'ARM_CLIENT_SECRET', secretName: {{$secretName}}, secretKey: {{$clientsecret}}),
       secretEnvVar(key: 'ARM_TENANT_ID', secretName: {{$secretName}}, secretKey: {{$tenantid}}),
       secretEnvVar(key: 'ARM_SUBSCRIPTION_ID', secretName: {{$secretName}}, secretKey: {{$subscriptionid}})
    }
}
    stages {
        stage("Create an AKS Cluster") {
            steps {
                script {
                    dir('Azure Kubernetes Service') {
                        sh "terraform init"
                        sh "terraform apply --auto-approve"
                    }
                }
            }
        }

        stage("Set up Prometheus"){
            steps{
                script {
                    dir('Montoring') {
                        sh "terraform init"
                        sh "terraform apply --auto-approve"
                    }
                }
            }
        }

        stage("Deploy Webb App"){
            steps{
                script {
                    dir('Web App Deployment') {
                        sh "terraform init"
                        sh "terraform apply --auto-approve"
                    }
                }
            }
        }

        stage("Deploy Sock-Shop App"){
            steps{
                script {
                    dir('Weave Sock Shop App') {
                        sh "terraform init"
                        sh "terraform apply --auto-approve"
                    }
                }
            }
        }
        stage("Set up SSL"){
            steps{
                script {
                    dir('SSL') {
                        sh "terraform init"
                        sh "terraform apply --auto-approve"
                    }
                }
            }
        }
      
        stage("Setup Ingress Routing") {
            steps {
                script {
                    dir('Ingress') {
                        sh "terraform init"
                        sh "terraform apply --auto-approve" 
                    }
                }
            }
        }
    }