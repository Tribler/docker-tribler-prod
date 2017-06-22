# Production docker image
This docker image is meant to make it easier to run Tribler by encapsulating
all the dependencies in a docker container.

## How to use
Currently this docker image only works on linux/unix machines, because of the way the gui is passed to the host's x server

To make use of this image, you first need to pull this image from docker hub:
```shell
docker pull tribler/docker-tribler-prod
```
 
Or build it yourself by building from this repository:
(For more options, see the building section below)
```shell 
git clone https://github.com/Tribler/docker-tribler-prod.git
docker build -t tribler/docker-tribler-prod docker-tribler-prod
```

When the image is pulled or built, it can be run by executing this command:
(For more options, see the running section below)
```shell
docker run -it \
-v /tmp/.X11-unix:/tmp/.X11-unix \ # Display
-e DISPLAY=unix$DISPLAY \          # Display
--device /dev/snd \                # Sound
-v $HOME/.Tribler:/home/tribler/.Tribler \ # State folder
-v $HOME/Downloads:/home/tribler/TriblerDownloads \ # Download folder
--name tribler \
tribler/docker-tribler-prod
```

After closing the Tribler application, it can be started again by running:
```shell
docker start tribler
```

To remove the container run:
```shell
docker rm tribler
```

## Running options
### Host networking (-net host)
The host networking options puts the container on the same networking bridge as the computer instead of being behind a shielded network. This option can help when you're having network connectivity problems.

```shell
docker run -it \
-v /tmp/.X11-unix:/tmp/.X11-unix \ # Display
-e DISPLAY=unix$DISPLAY \          # Display
--device /dev/snd \                # Sound
--net host                         # Networking
-v $HOME/.Tribler:/home/tribler/.Tribler \ # State folder
-v $HOME/Downloads:/home/tribler/TriblerDownloads \ # Download folder
--name tribler \
tribler/docker-tribler-prod
```

### CPU restrictions (-ccpuset-cpus)
The cpu restriction option lets you decide how much cpu power the container may use. In more technical terms it lets you decide which cpu core/thread the program can use.

```shell
docker run -it \
-v /tmp/.X11-unix:/tmp/.X11-unix \ # Display
-e DISPLAY=unix$DISPLAY \          # Display
--device /dev/snd \                # Sound
--cpuset-cpus 0 \                  # CPU restriction
-v $HOME/.Tribler:/home/tribler/.Tribler \ # State folder
-v $HOME/Downloads:/home/tribler/TriblerDownloads \ # Download folder
--name tribler \
tribler/docker-tribler-prod
```

### Memory restrictions (--memory)
The memory restriction option lets you decide how much memory space the container may use.

```shell
docker run -it \
-v /tmp/.X11-unix:/tmp/.X11-unix \ # Display
-e DISPLAY=unix$DISPLAY \          # Display
--device /dev/snd \                # Sound
--memory 512mb \                   # Memory restriction
-v $HOME/.Tribler:/home/tribler/.Tribler \ # State folder
-v $HOME/Downloads:/home/tribler/TriblerDownloads \ # Download folder
--name tribler \
tribler/docker-tribler-prod
```

## Building options
### REPO_URL (Default: https://github.com/Tribler/tribler.git)
The REPO_URL env variable lets you change the repository url of code that the image is going to pull. This can be used for packaging forks of tribler.

```shell
docker build -t tribler/docker-tribler-prod \
-e REPO_URL=<url of code repository> \
docker-tribler-prod
```

### VERSION (Default: next)
The VERSION env variable lets you change the specific version that is built during the packaging. This is handled by changing the branch of the repository. So in this way branches and tags can be selected.

```shell
docker build -t tribler/docker-tribler-prod \
-e VERSION=<version> \
docker-tribler-prod
```
