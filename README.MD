## PeakApp

I am open to technical review, and I am open to criticism. I did this on the fly without referencing any of my existing code. (I pulled up the docs. ofcourse.) It is no problem to go more advanced.

### Dockerfile
> Write a Dockerfile to package this flask Application as a container.

* Base Debian Environment + python/pip and basic tools
* app.py + requirements for Flask
* EXPOSE 5000/tcp just as a heads up.

### Kube
> Write the necessary kubernetes manifests to deploy this container as a web application.

> In addition, use the most efficient cloud costs management approach when creating your manifests in case the company decides to create 20 additional similar applications.

* Deployment files for a basic ReplicaSet for each environment.
  - Dev, Integration, UAT, Prod

### Infrastructure
* I went basic on this. No SSL. No custom ELB. No custom networking. Simple straight forward MVP.
  - doc/infrastructure.md

### CI/CD
* I didn't code this all the way out. I setup a basic Jenkinsfile for Dev. but I didn't give away all of it.
  - doc/ci_cd.md

### Deployment
* Went to code a Terraform module for this, but I don't know what cloud environment you are using.
