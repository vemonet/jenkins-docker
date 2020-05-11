FROM jenkins/jenkins:lts

LABEL maintainer  "Vincent Emonet <vincent.emonet@maastrichtuniversity.nl>"

USER root
RUN groupadd docker
RUN usermod -aG docker jenkins
RUN apt-get update -qq
RUN apt-get install -qqy apt-transport-https ca-certificates lsb-release

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" >> /etc/apt/sources.list.d/additional-repositories.list

RUN apt-get update -qq
RUN apt-get install -qqy docker-ce docker-ce-cli containerd.io

RUN curl -L --fail https://github.com/docker/compose/releases/download/1.25.5/run.sh -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose