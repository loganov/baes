## CI / CD Pipeline
> "...automatically build and deploy this application to dev --> int --> uat --> prod environments with every Git push."

* I will be referring to build systems generically as Jenkins as this is my primary platform.
* I will be referring to any source control system that supports Git protocol as 'Git'. (ie. GitHub, Gitbucket, Bamboo, et al.)

### GitHub Triggers

### Push Trigger
Setup up Jenkins with a Git plugin, add an SSH key to Git so Jenkins can hit the endpoint. Configure Jenkins to listen for a call. (This will kick off the dev. build in the pipeline, first step.) Most of this can be added to base configuration for repeatability, not configured through the Jenkins UI.

### Polling
Depending on security and configuration you may not be able to get a push from Git, you may have to poll intermittently for new commits. Every 5-10 minutes is usually fine, but if you have a lot of jobs and and repos it can put a strain on the Jenkins primary.


### "The Pipeline"
Assuming a Jenkins primary deployed in a cloud environment, you'll need different jenkins-agent images for different work loads. (Also, once Jenkins is up we can dogfood, and use Jenkins to build and keep agents up to date if you are checking your CI/CD pipe into source control.)

All of the tooling necessary to deploy to AWS/GCP is to be built in to the agent images. Jenkins pipe gets kicked off by a Git commit, 'Dev' is up first. A docker image with the appropriate tooling is spun up as an agent, and this agent interacts with the cloud ```(gcloud, aws-cli)``` to create instances and kick off configuration. Same for the other environments in the pipeline.
  * This is all policy based. You have to grant the jenkins agents a lot for your cloud provider.

For Instance: jenkins-agent images:
* Dev environment agent needs a minimal image, but with sdks, libraries, base testing tools. Unit test platform.

* Internal testing agent image would pretty much be the same, but the Jenkins job would be different. Synthetic tests. Possibly tools integrated into the image for load testing.

* UAT - If you have a dedicated UAT team, again, you're going to need tools for UAT to hit instances with synthetics, load testing, fail over testing, etc.

* Production - Lightest weight agent. Laser focus on deployment.

#### Progression
Jenkins 3.x and other build tools have really gotten their act together on tightly knit pipelines.

* Git kicks off the trigger for a given repo. Dev agent runs the unit tests against an instance, the tests passed... Check Ansible/automation code. (Is apache installed?) Pass it to Internal/Integration testing job.

* Int - all pinned libraries are checked. Interaction between microservices is checked. External/3rd party APIs, etc. Build is tagged and logged.

* UAT - Identical 'hardware' to Prod. Load tested. Synthetic tests.

* Production - Personally, I always like a human to 'hit the button' for production. If that is not the case then we need to look at "A/B" tests, or a subset of the environment for canary testing.

### Monitoring and Alerting
This isn't part of the test but we should talk about this. Both in terms of application deployment and success/failure logs coming out of Jenkins so we can have a 'big board'. (Grafana or similar. This is red, this is green...)
