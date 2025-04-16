pipeline {
    agent any
 
    environment {
        TERRAFORM_VERSION = '1.5.0'  // Replace with your Terraform version
        AWS_REGION = 'us-east-1'    // Replace with your preferred AWS region
    }
 
    parameters {
        booleanParam(name: 'APPLY_CHANGES', defaultValue: false, description: 'Apply the Terraform plan if true')
    }
 
    stages {
        stage('Checkout Project') {
            steps {
                echo 'Checking out the repository...'
                git branch: 'main', credentialsId: 'git-sidhu', url: 'https://github.com/siddhartha-surnoi/logistics-terraform.git'
            }
        }
 
        stage('Setup Terraform') {
            steps {
                echo 'Setting up Terraform...'
                sh '''
                    terraform -version || {
                        curl -o terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
                        unzip terraform.zip
                        mv terraform /usr/local/bin/
                        rm terraform.zip
                    }
                '''
            }
        }
 
        stage('Initialize Terraform') {
            steps {
                echo 'Initializing Terraform...'
                dir('vpc-terraform/module') { // Adjust to your Terraform directory structure
                    sh 'terraform init'
                }
            }
        }
 
        stage('Validate Terraform') {
            steps {
                echo 'Validating Terraform files...'
                dir('vpc-terraform/module') {
                    sh 'terraform validate'
                }
            }
        }
 
        stage('Plan Terraform') {
            steps {
                echo 'Creating a Terraform plan...'
                dir('vpc-terraform/module') {
                    sh 'terraform plan'
                }
            }
        }
 
        stage('Apply Terraform') {
            when {
                expression { return params.APPLY_CHANGES }
            }
            steps {
                echo 'Applying the Terraform plan...'
                dir('vpc-terraform/module') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
 
    post {
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline failed. Please check the logs.'
        }
        // cleanup {
        //     echo 'Cleaning up resources...'
        //     dir('vpc-terraform/module') {
        //         sh 'terraform destroy -auto-approve || true'
        //     }
        // }
    }
}