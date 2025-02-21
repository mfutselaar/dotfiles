#!/bin/bash

# Exit on any error
set -e

# Detect the Linux distribution
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    echo "Cannot detect the Linux distribution."
    exit 1
fi

# Check for Ubuntu or Debian
if [ "$OS" != "ubuntu" ] && [ "$OS" != "debian" ]; then
    echo "This script only supports Ubuntu and Debian."
    exit 1
fi

# Install prerequisites
apt-get update
apt-get install -y apt-transport-https ca-certificates curl

# Install containerd
apt-get install -y containerd

# Configure containerd
mkdir -p /etc/containerd
containerd config default | tee /etc/containerd/config.toml

# Start and enable containerd
systemctl restart containerd
systemctl enable containerd

# Add Kubernetes repository
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
mkdir -p /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | tee /etc/apt/keyrings/kubernetes-archive-keyring.gpg > /dev/null
cat <<EOF > /etc/apt/sources.list.d/kubernetes.list
deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /
EOF

# Update package lists and install Kubernetes components
apt-get update
apt-get install -y kubelet kubeadm kubectl

# Enable kubelet service
systemctl enable kubelet

# Ensure necessary modules are loaded
modprobe overlay
modprobe br_netfilter

# Set up required sysctl params, these persist across reboots
cat <<EOF > /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sysctl --system

echo "Kubernetes installation on Ubuntu/Debian completed!"
