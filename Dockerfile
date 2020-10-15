FROM cloudbees/cloudbees-core-mm:2.249.2.4

LABEL maintainer "phil.cherry@cloudbees.com"

USER root

ARG user=jenkins

#skip setup wizard and disable CLI
ENV JVM_OPTS -Djenkins.install.runSetupWizard=false -Djenkins.CLI.disabled=true -server

#config-as-code plugin configuration
#COPY config-as-code.yml /usr/share/jenkins/config-as-code.yml
#ENV CASC_JENKINS_CONFIG /usr/share/jenkins/config-as-code.yml

#install suggested and additional plugins
ENV JENKINS_UC http://jenkins-updates.cloudbees.com
ENV TRY_UPGRADE_IF_NO_MARKER=true

RUN mkdir -p /usr/share/jenkins/ref/plugins
RUN chown -R ${user} /usr/share/jenkins/ref

# Install unzip for jenkins-support
RUN yum -y install unzip

USER ${user}

COPY plugins.txt plugins.txt
COPY jenkins-support /usr/local/bin/jenkins-support
COPY install-plugins.sh /usr/local/bin/install-plugins.sh
RUN /usr/local/bin/install-plugins.sh $(cat plugins.txt)
