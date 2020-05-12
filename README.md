Jenkins LTS image with Docker installed to run Docker container using Jenkins.

## Run

Image pulled from [DockerHub](https://hub.docker.com/repository/docker/umids/jenkins-docker)

* Run on localhost:8080

```bash
docker run -d --rm --name ids-jenkins -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock:ro -v /data/jenkins/jenkins_home/:/var/jenkins_home umids/jenkins-docker
```

* Deploy publicly using [jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy)

```bash
docker run -d --rm --name ids-jenkins -v /var/run/docker.sock:/var/run/docker.sock:ro -v /data/jenkins/jenkins_home/:/var/jenkins_home -e VIRTUAL_HOST=jenkins.MY_IP_ADDRESS.nip.io -e LETSENCRYPT_HOST=jenkins.MY_IP_ADDRESS.nip.io -e VIRTUAL_PORT=8080 umids/jenkins-docker
```

* Share SSH keys (to clone private git repo using SSH)

```bash
docker run -d --rm --name ids-jenkins -v /data/.ssh:/root/.ssh -v /var/run/docker.sock:/var/run/docker.sock:ro -v /data/jenkins/jenkins_home/:/var/jenkins_home -e VIRTUAL_HOST=jenkins.MY_IP_ADDRESS.nip.io -e LETSENCRYPT_HOST=jenkins.MY_IP_ADDRESS.nip.io -e VIRTUAL_PORT=8080 umids/jenkins-docker
```

> The .ssh folder needs to be owned by the `root` user and in `/data`.
>
> Use the SSH config file from this repository:
>
> ```bash
> mkdir -p /data/.ssh
> cp ssh_config /data/.ssh/config
> ```

## Build

```bash
docker build -t umids/jenkins-docker .
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
    docker exec -i -t ids-jenkins bash
    docker login
    ```

* To enable Git clone from SSH, add the following to `/root/.ssh/config`

```bash
Host github.com
 Hostname ssh.github.com
 Port 443
```

