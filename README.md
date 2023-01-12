B1 Docker image installation
=============================

- [1. Install docker](#1-install-docker)
- [2. Download the docker image](#2-download-the-docker-image-todo)
- [3. Build Container](#3-build-container)
- [4. Start container](#4-start-container)
- [5. Save changes to new container](#5-save-changes-to-new-container)

## 1. Install docker

- Install Docker Engine:

https://docs.docker.com/engine/install/ubuntu/
<br/><br/>
- If your computer has a NVIDIA GPU, install **nvidia-docker 2.0** to use Hardware Acceleration, otherwise you can skip this step:

https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker
<br/><br/>
- Enable docker run without need of *sudo* privileges:

```
sudo groupadd docker
sudo usermod -aG docker ${USER}
su - ${USER}  //or log out and log in
sudo systemctl restart docker
```
Add autocomplete capabilities for docker commands (optional)

- Install Docker-compose

```
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
or
sudo apt install -y docker-compose
docker-compose --version
```

- Add bash completion for docker & docker-compose

```
sudo apt-get install -y bash-completion
sudo curl https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker -o /etc/bash_completion.d/docker.sh
sudo curl -L https://raw.githubusercontent.com/docker/compose/1.25.1/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
```

## 2. Download the docker image (TODO)

- You can download the already built image [~X.xGB] from this [link](TODO). 
- Load the docker image:

```
docker load -i ~/Downloads/b1_docker.tar
```
&nbsp;
- Now, the image should appear in your docker images list:

```
docker images
```

The output should be something like the following result:

```
REPOSITORY     TAG         IMAGE ID       CREATED        SIZE
B1_docker   latest      ############   # months ago   4.1GB

```

## 3. Build Container
- To build and run the Docker container execute the build_docker.sh and run_docker.sh scripts.
```
./build_docker.sh 
./run_docker.sh 
```
- This should automatically start a docker session, the live session should be visible by tipying:
```
docker ps -a
```
## 4. Start Container
- To execute a running container (visible with `docker ps -a`), fisrt it needs to be started by running:

```
docker start <NAME>
```
Then it can be executed by
```
docker exec -it <NAME> bash
```
## 5. Save changes to new container
If you have done some modifications to the original container, either install new packages or configurations files, you can generate a permanent new image with those changes by following this steps:
- First list all available images by typing:
```
docker images
```
- Then, list your running containers:
```
docker ps -a
```
- Now select the name of the container (from the list of running containers) with the changes and commit them:
 ```
docker commit <CONTAINER_NAME>
```
- This should create a new image, it should appear when typping (TAG should be < none >):
```
docker images
```
- Give the image a descriptive tag by:
```
docker tag <IMAGE_ID> <YOUR_TAG>
```
- Aditionally, you can generate a permanent file from the image by saving it as:
```
docker save <REPOSITORY_NAME> > <DESIRED_FILENAME>.tar
```
