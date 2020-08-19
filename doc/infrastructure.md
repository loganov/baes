# Infrastructure

### Load Balancers

* I'm just going to call servers, instances, pods, whatever - 'targets'.

#### SSL Termination
There are a couple of options when it comes to SSL, load balancers, and targets.

1. Terminate at the load balancer. SSL cert chain is placed on the server - AWS, IAM, GCP equivalent, whatever you want. Traffic then goes unencrypted to the targets. (Based on policy of course.)

2. Terminate at the target. ie. Straight traffic from the outside, through the load balancer unimpeded. Load the certificate into Nginx on the target and set the load balancer for straight TCP traffic, not HTTP.

3. There is a third option - using two sets of keys. One for externally facing, and one for internal traffic routed on the network. So for instance we would could have one key decrypt traffic at the LB, and then re-encrypt with a different certificate for internal transit.

### Internal vs. External Networking
* "Or, How I learned to stop worrying about microservices."

#### Internal
Even with the cost incurred for using internal VPC networking, if you've got HA systems and you're trying to backup or sync 2Tb worth of Cassandra data a day, that gets prohibitively expensive fast on a public-facing-node to public-facing-node connection. Better to just go with 'internal' data transfer costs. (Also AWS is particularly stingy in this area in terms of internal private networks and IPs. )

#### External
* Service to Service
  -External routing with publicly available instances. Dogfooding your own APIs, etc.

* Externally Serving
  - This is just content, or edge systems. Usually nginx, or nodejs, feeding into a message queue. Or for tokens and auth.

### Networking
If you were serving static content, whether or not it is getting pulled from a CDN, my basic recommendation would be... A Kube ReplicaSet, no point in doing Stateful if you are just serving simple content. Pod goes down, another one takes it's place. Simple HTTPS loadbalancer up front, with the SSL cert and firewall policies, and the pods take cleartext traffic internally.

### Automation and Management
For 'golden images' load as much as you can into the Packer build. For 'lean' images, ```cloud-init``` will handle initial configuration before Ansible can take over.

For Docker/Kube...enjoy your sidecar...for your monitoring and anything else you actually need. (Or if you're running a JaveEE stack you can publish the JMX port.)

Terraform to manage resources. ```cloud-init```, CloudFormation, etc.
