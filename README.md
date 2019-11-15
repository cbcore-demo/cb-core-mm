# CloudBees Core Managed Master 
## Custom Managed Master Docker Image
This repository provides an example for creating a custom container (Docker) image to use as a [Managed Master](https://go.cloudbees.com/docs/cloudbees-core/cloud-admin-guide/operating/#managing-masters) *Docker image template* to be provisioned by CloudBees Core Operations Center running on Kubernetes. 

The image is configured to skip the Jenkins 2 Setup Wizard, install all of the CloudBees recommended plugins (minus a few) and some additional plugins typically used by CloudBees SAs for demos and workshops, and auto-configure the Jenkins instances. This *config-as-code* results in a streamlined CloudBees Core Managed Master provisioning process.

### Dockerfile
- The `Dockerfile` starts with a `FROM` value of the CloudBees Core Managed Master Docker image: `cloudbees/cloudbees-core-mm`. 
- The `RUN /usr/local/bin/install-plugins.sh $(cat plugins.txt)` command installs all the plugins.
- The `config-as-code.yml` file provides Configuration-as-Code via [the Jenkins CasC plugin](https://github.com/jenkinsci/configuration-as-code-plugin).

#### Plugins installed:
See the [`plugins.txt`](plugins.txt) file to see all the plugins that get installed - some *non-CJE standard plugins* highlights include:

- [Blue Ocean with the Blue Ocean Pipeline Editor](https://jenkins.io/doc/book/blueocean/)
- [Pipeline Utilities plugin](https://jenkins.io/doc/pipeline/steps/pipeline-utility-steps/)
- [Jenkins Configuration as Code Plugin](https://github.com/jenkinsci/configuration-as-code-plugin)

Note, the `install-plugins.sh` script will download the specified plugins and their dependencies at build time and include them in the image; it also inspects the Jenkins WAR and skips any plugins already included by CloudBees (embedded in the WAR).
