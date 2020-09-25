# AzureDNSProxy

This is a container version of Microsoft's Private Links DNS Proxy https://github.com/microsoft/PL-DNS-Proxy

Useful for proxying Azure DNS for Private Link, Private Endpoints, and Private DNS. Container is intended to be deployed to Azure Kubernetes Service. To be tested on AppService Enviroment.

Docker Hub : https://hub.docker.com/r/neerpatel/azurednsproxy

## To deploy
### Docker
    docker run -d -p 53:5353 -p 53:5353/udp  --restart=always neerpatel/azurednsproxy:latest
    .
### AKS deployment
    kubectl apply -f https://raw.githubusercontent.com/neerpatel/AzureDNSProxy/master/k8s-azurednsproxy.yml

## 🔧 Contribution

Your contribution is very welcomed!
Please create pull request or issue.