# AzureDNSProxy

This is a container version of Microsoft's Private Links DNS Proxy https://github.com/microsoft/PL-DNS-Proxy

Useful for proxying Azure DNS for Private Link, Private Endpoints, and Private DNS. Container is intended to be deployed to Azure Kubernetes Service. To be tested on AppService Enviroment.

Docker Hub : https://hub.docker.com/r/neerpatel/azurednsproxy

## To deploy
### Docker
    docker run -d -p 53:53 -p 53:53/udp  --restart=always neerpatel/azurednsproxy:latest
### Kubernetes
    
## 🔧 Contribution

Your contribution is very welcomed!
Please create pull request or issue.