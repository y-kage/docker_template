# Sample Pytorch Project with Docker
https://github.com/sh1027/docker_pytorch

## Install
Clone repositry
```bash
git clone git@github.com:sh1027/docker_pytorch.git
```

Modify `docker/.env`
```bash
COMPOSE_PROJECT_NAME=$USER
UID=1000  # <- replace with your UID
GID=1000  # <- replace with your GID
WORKDIR_LOCAL=PATH_TO_WORKDIR  # <- replace with your WORKDIR
```
You can check your UID and GID from the command below.
```bash
id -u # UID
id -g # GID
```

Docker compose up
```bash
cd docker
docker-compose up -d
# to build
docker-compose up -d --build
```

Execute command in Docker
```bash
docker exec -it -w /workspace {USER_NAME} bash
```
docker exec -it -w /workspace kageyama-pytorch-env-1 bash

As root
```bash
docker exec -it -u 0 -w /workspace {USER_NAME} bash
```
docker exec -it -u 0 -w /workspace kageyama-pytorch-env-1 bash
docker exec -it -w /workspace mydl bash

## Using JupyterLab (Optional)
```bash
python -m jupyterlab --ip 0.0.0.0 --port {CONTAINER_PORT} --allow-root
```
python -m jupyterlab --ip 0.0.0.0 --port 8866 --allow-root




# Before Starting
Modify files.


## .env
Change uid, gid, workdir, ports.
```bash
id -u # UID
id -g # GID
```


## docker-compose.yaml
Change image, container_name, volumes, shm_size if needed.
- image : name of image cached to local. if exist, load, if not, build.
- container_name : name used to get in the container.
- volumes : Correspondence. {local_dir}:{container_dir}
- shm_size : shared memory size. check your spec.


## Dockerfile
Change docker image, libraries, python version.


# Commands

Docker compose up
```bash
cd docker && docker-compose up -d
```

If Dockerfile changed, Docker compose up with build
```bash
cd docker && docker-compose up -d --build
```

Execute command in Docker
```bash
docker exec -it {container_name} bash
# or
docker exec -it -w {WORK_DIR_PATH} {container_name} bash
```

As root
```bash
docker exec -it -u 0 -w {WORK_DIR_PATH} {container_name} bash
```

Using JupyterLab (Optional)
```bash
python -m jupyterlab --ip 0.0.0.0 --port {CONTAINER_PORT} --allow-root
```

Using Tensorboard
```bash
tensorboard --logdir=/workspace/PytorchLightning/lightning_logs --host=0.0.0.0 --port={CONTAINER_PORT}
# or
python /home/{USER}/.local/lib/python3.9/site-packages/tensorboard/main.py --logdir=/workspace/PytorchLightning/lightning_logs --host=0.0.0.0 --port={CONTAINER_PORT}
```

Login W & D
```bash
wandb login
# or
python3 -m wandb login
# or
/usr/bin/python3 -m wandb login
```
