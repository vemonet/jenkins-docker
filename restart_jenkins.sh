#!/bin/bash

$JENKINS_URL=jenkins.MY_IP_ADDRESS.nip.io

docker stop ids-jenkins

docker run -d --rm --name ids-jenkins -v /data/.ssh:/root/.ssh -v /var/run/docker.sock:/var/run/docker.sock:ro -v /data/jenkins/jenkins_home/:/var/jenkins_home -e VIRTUAL_HOST=$JENKINS_URL -e LETSENCRYPT_HOST=$JENKINS_URL -e VIRTUAL_PORT=8080 umids/jenkins-docker:latest

docker exec -i -t ids-jenkins docker login -u $1 -p $2