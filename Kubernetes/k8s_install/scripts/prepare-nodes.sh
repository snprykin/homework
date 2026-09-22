#!/bin/bash
# Подготовка ноды к установке Kubernetes
set -e

# Отключаем swap
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# Загружаем модули ядра
sudo modprobe overlay
sudo modprobe br_netfilter

# Настраиваем sysctl
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sudo sysctl --system
echo "Подготовка завершена"
