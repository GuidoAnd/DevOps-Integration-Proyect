# <div style="text-align: center; color: black;">Automatizate && Continuos Deployment</div> 

## Context:

####  Once Kubernetes has been integrated into the development workflow, further challenges arise.  For example, deploying the application across different environments. As a result, the team needs to create a manifest for each environment.  
#### To resolve this issue, the development team discovered a new tool. This tool, called Helm, enables the creation of a manifest template that can be deployed in any environment.

#### Kubernetes significantly accelerated development, but this caused a synchronisation issue with the infrastructure team. The numerous changes resulted in multiple versions, and deploying them all at the same time would be a challenge.
#### One way to resolve this conflict was to adopt a GitOps approach, whereby the main repository contains the actual code and allows other developers to review any changes. also adopted a new tool called ArgoCD. This enables to manage changes and roll them out should any issues arise. 

#

## Second Repository (only for Helm Manifests):
* #### 

#

## Tools/Services:

* #### Multi-Container orchetastor - Kubernetes
* #### Automatized manifest templates for Kubernetes - Helm
* #### Repositories - Github
* #### Declarative Continuos deployment - ArgoCD