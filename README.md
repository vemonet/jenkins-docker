Jenkins LTS image with Docker installed to run Docker container using Jenkins.

## Run

Image pulled from [DockerHub](https://hub.docker.com/repository/docker/umids/ids-jenkins)

```bash
docker run -d --name ids-jenkins -v /var/run/docker.sock:/var/run/docker.sock:ro -v /data/jenkins/jenkins_home/:/var/jenkins_home -o 8080:8080 umids/ids-jenkins
```

## Build

```bash
docker build -t umids/ids-jenkins .
```

## Details

If need, in the UI config, Docker API URL is: `unix:///var/run/docker.sock`

Create new Jenkins pipeline from Jenkinsfile on GitHub:

* Create new `Pipeline`

* Pipeline Definition: `Pipeline script from SCM`

  * SCM: `Git`
  * Provide your repository URL

* Add WebHook to the GitHub repository to build on Push

  * https://username:pw@jenkins.MY_URL.nip.io/github-webhook/

* Go inside the Jenkins container and **login** to be able to `docker push`:

  * ```bash
    docker exec -i -t jenkins bash
    docker login
    ```