#!/bin/bash

# ================================
# Backend Environment Setup Script (Amazon Linux)
# Author: Nandula Saraswathi
# Date: $(date)
# ================================

USERID=$(id -u)
echo "Current user access by ID: $USERID"
if [ "$USERID" -ne 0 ]; then
  echo "Please access using Sudo or Root user"
  exit 1
fi

# Error Handling
set -e
trap 'echo "ERROR: Script failed at line $LINENO."' ERR

# Log File
LOG_FILE="setup.log"
exec > >(tee -a "$LOG_FILE") 2>&1
echo "========== Script Execution Started at $(date) ==========" >> "$LOG_FILE"

# System Compatibility Check
OS_VERSION=$(grep -w NAME /etc/os-release | cut -d '"' -f 2)
if [[ "$OS_VERSION" != "Amazon Linux" ]]; then
    echo "ERROR: This script is intended for Amazon Linux only."
    exit 1
fi

# Function to install a package if not already installed
install_package() {
    if ! rpm -q "$1" &>/dev/null; then
        echo "Installing $1..."
        sudo yum install -y "$1"
        echo "Successfully installed $1."
    else
        echo "$1 is already installed."
    fi
}

# Step 1: Install Git
install_package git

# Step 2: Install Java 21
JAVA_VERSION=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}' || echo "Not Installed")
if [[ "$JAVA_VERSION" =~ ^21 ]]; then
    echo "Java 21 is already installed."
else
    install_package java-21-amazon-corretto-devel
    sudo alternatives --config java <<< "1"
    echo "Java 21 set as default."
fi

# Step 3: Install Maven 3.9.8
MAVEN_VERSION="3.9.8"
MAVEN_HOME="/opt/maven"
MAVEN_TAR="apache-maven-${MAVEN_VERSION}-bin.tar.gz"

if ! command -v mvn &>/dev/null; then
    echo "Installing Maven ${MAVEN_VERSION}..."
    install_package wget

    if [ -d "$MAVEN_HOME" ]; then
        echo "Existing Maven directory found. Removing..."
        sudo rm -rf "$MAVEN_HOME"
    fi

    wget "https://downloads.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/${MAVEN_TAR}"
    sudo tar -xvzf "${MAVEN_TAR}" -C /opt
    sudo mv "/opt/apache-maven-${MAVEN_VERSION}" "$MAVEN_HOME"

    echo "export M2_HOME=$MAVEN_HOME" | sudo tee /etc/profile.d/maven.sh
    echo "export M2=\$M2_HOME/bin" | sudo tee -a /etc/profile.d/maven.sh
    echo "export MAVEN_OPTS=\"-Xms256m -Xmx512m\"" | sudo tee -a /etc/profile.d/maven.sh
    echo "export PATH=\$M2:\$PATH" | sudo tee -a /etc/profile.d/maven.sh
    sudo chmod +x /etc/profile.d/maven.sh
    source /etc/profile.d/maven.sh

    echo "Maven ${MAVEN_VERSION} installed successfully."
    rm -f "${MAVEN_TAR}"
else
    echo "Maven is already installed."
fi

# Step 4: Install Jenkins
if ! systemctl list-units --type=service | grep -q jenkins; then
    echo "Installing Jenkins..."
    install_package fontconfig
    install_package java-21-amazon-corretto
    sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
    sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
    install_package jenkins
    sudo systemctl start jenkins
    sudo systemctl enable jenkins
    echo "Jenkins service started."
else
    echo "Jenkins is already installed."
fi

# Step 5: Configure Firewall for Jenkins
echo "Configuring Firewall for Jenkins..."
if command -v firewall-cmd &>/dev/null; then
    sudo firewall-cmd --permanent --add-port=8080/tcp
    sudo firewall-cmd --reload
    echo "Firewall rules updated using firewalld."
elif command -v iptables &>/dev/null; then
    sudo iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
    sudo iptables-save | sudo tee /etc/sysconfig/iptables
    echo "Firewall rules updated using iptables."
else
    echo "WARNING: No firewall management tool found. Manually open port 8080 if required."
fi

# kubectl
 curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.31.0/2024-09-12/bin/linux/amd64/kubectl
 chmod +x ./kubectl
 mv kubectl /usr/local/bin/kubectl
 VALIDATE $? "kubectl installation"
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.31.0/2024-09-12/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv kubectl /usr/local/bin/kubectl

# Step 7: Install eksctl
if ! command -v eksctl &>/dev/null; then
    echo "Installing eksctl..."
    curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
    sudo mv /tmp/eksctl /usr/local/bin
    echo "eksctl installed successfully."
else
    echo "eksctl is already installed."
fi

# Step 8: Verify Installations
echo "Verifying Installations..."
echo "Git Version: $(git --version)"
echo "Java Version: $(java -version 2>&1 | head -n 1)"
echo "Maven Version: $(mvn -version | head -n 1)"
echo "Jenkins Status: $(sudo systemctl is-active jenkins)"
echo "kubectl Version: $(kubectl version --client --short || echo 'Not found')"
echo "eksctl Version: $(eksctl version || echo 'Not found')"

# Step 9: Summary Table
echo ""
echo "===== Installation Summary ====="
printf "%-15s : %s\n" "Git" "$(git --version)"
printf "%-15s : %s\n" "Java" "$(java -version 2>&1 | head -n 1)"
printf "%-15s : %s\n" "Maven" "$(mvn -version | head -n 1)"
printf "%-15s : %s\n" "Jenkins" "$(sudo systemctl is-active jenkins)"
printf "%-15s : %s\n" "kubectl" "$(kubectl version --client --short || echo 'Not Found')"
printf "%-15s : %s\n" "eksctl" "$(eksctl version || echo 'Not Found')"


