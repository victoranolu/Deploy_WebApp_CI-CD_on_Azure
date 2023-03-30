# Automating Kubernetes on Azure - AKS and DevOps

## Preclude
Azure Kubernetes Service a.k.a AKS - is a fully managed service that helps to deploy a managed Kubernetes cluster on Azure.

The post management of cluster - Upgrade, Patching, Monitoring - all come as a package. The other important feature is the management of the Master Nodes of the cluster - this is completely a black box for the user and is entirely maintained by Azure. Users are left with managing only the Worker Nodes and associated components.

But AKS cluster is not the only thing that user(s) are going to create; rather the ancillary services around the cluster helping build the entire architecture is most important, painfully redundant and difficult to manage in long terms - more so when you think of the Operations team or Infrastructure management team - who might need to do this for multiple cluster to be managed and many applications to be deployed!

Hence a disciplined, streamlined and automated approach is needed so that end to end architecture becomes robust, resilient and easily manageable.

The purpose of this workshop would be to:

* Use Kubernetes as the tool or orchestration of micro-services
* Deploy a microservice app, Weave Sock-Shop
* Deploy another web app
* Build an automated pipeline for creating the infrastructure for the deploying of the microservices
* Leverage AKS as a hosted service around Kubernetes (a.k.a K8s) for better manageability, less complexity
* Use the built-in features of AKS for monitoring, security and upgrades