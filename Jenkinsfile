pipeline {
    agent any

    environment {
        TERRAFORM_VERSION = '1.5.0'
        AWS_REGION = 'us-east-1'
        PATH = "${env.HOME}/bin:${env.PATH}"
        TF_DIR = 'vpc-terraform/module' // Default Terraform working directory
    }

    parameters {
        booleanParam(name: 'APPLY_CHANGES', defaultValue: false, description: 'Apply the Terraform plan if true')
        booleanParam(name: 'DESTROY_INFRA', defaultValue: false, description: 'Destroy the Terraform-managed infrastructure')
        choice(name: 'ENVIRONMENT', choices: ['dev', 'qa', 'staging', 'prod'], description: 'Choose deployment environment')
        string(name: 'TF_WORKING_DIR', defaultValue: 'vpc-terraform/module', description: 'Path to the Terraform module directory')
    }

    options {
        timestamps()
        disableConcurrentBuilds()
    }

    stages {
        stage('Build Metadata') {
            steps {
                echo "\033[1;34mBUILD INFO:\033[0m"
                echo "Build Number: ${env.BUILD_NUMBER}"
                echo "Build URL: ${env.BUILD_URL}"
                echo "Environment: ${params.ENVIRONMENT}"
            }
        }

        stage('Checkout Project') {
            steps {
                echo "\033[1;32mChecking out the repository...\033[0m"
                git branch: 'main', credentialsId: 'git-sidhu', url: 'https://github.com/siddhartha-surnoi/logistics-terraform.git'
            }
        }

        stage('Setup Terraform') {
            steps {
                echo "\033[1;32mSetting up Terraform...\033[0m"
                sh '''
                    mkdir -p $HOME/bin
                    export PATH=$HOME/bin:$PATH

                    if ! command -v terraform >/dev/null; then
                        echo "Terraform not found. Installing..."
                        curl -s -o terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
                        unzip -o terraform.zip
                        mv -f terraform $HOME/bin/
                        rm -f terraform.zip
                    else
                        echo "Terraform already installed."
                    fi

                    terraform -version
                '''
            }
        }

        stage('Initialize Terraform') {
            steps {
                echo "\033[1;36mInitializing Terraform...\033[0m"
                dir("${params.TF_WORKING_DIR}") {
                    sh 'terraform init -input=false'
                }
            }
        }

        stage('Validate Terraform') {
            steps {
                echo "\033[1;36mValidating Terraform files...\033[0m"
                dir("${params.TF_WORKING_DIR}") {
                    sh 'terraform validate'
                }
            }
        }

        stage('Plan Terraform') {
            steps {
                echo "\033[1;36mCreating a Terraform plan...\033[0m"
                dir("${params.TF_WORKING_DIR}") {
                    sh "terraform plan -var='environment=${params.ENVIRONMENT}'"
                }
            }
        }

        stage('Apply Terraform') {
            when {
                expression { return params.APPLY_CHANGES && !params.DESTROY_INFRA }
            }
            steps {
                echo "\033[1;33mApplying the Terraform plan...\033[0m"
                dir("${params.TF_WORKING_DIR}") {
                    sh "terraform apply -auto-approve -var='environment=${params.ENVIRONMENT}'"
                }
            }
        }

        stage('Destroy Terraform') {
            when {
                expression { return params.DESTROY_INFRA }
            }
            steps {
                input message: "Are you sure you want to destroy infrastructure in '${params.ENVIRONMENT}'?", ok: "Yes, destroy it"
                echo "\033[1;31mDestroying infrastructure...\033[0m"
                dir("${params.TF_WORKING_DIR}") {
                    sh "terraform destroy -auto-approve -var='environment=${params.ENVIRONMENT}'"
                }
            }
        }
    }

    post {
        success {
            echo "\033[1;32m Pipeline executed successfully!\033[0m"
        }
        failure {
            echo "\033[1;31m Pipeline failed. Please check the logs.\033[0m"
        }
    }
}
