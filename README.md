# Before Starting
Modify files.

- Modify `docker/.env`
  ```bash
  COMPOSE_PROJECT_NAME=$USER  # <- replace with your PROJECT NAME if necessary
  UID=1010  # <- replace with your UID
  GID=1010  # <- replace with your GID
  IMAGE_LABEL=pytorch:1131  # <- replace with your CONTAINER IMAGE LABEL to cache docker image with label if necessary
  CONTAINER_NAME=mydl  # <- replace with your CONTAINER NAME if necessary
  USER_NAME=custom  # <- set any name used as user name in container
  WORKDIR_CONTAINER=/home/${USER_NAME}/workspace/  # <- replace with your container WORKDIR, except /home/${USER_NAME}
  WORKDIR_LOCAL=/home/kageyama/osx/  # <- replace with your local WORKDIR
  HOST_PORT=8866  # <- replace with your HOST_PORT if necessary
  CONTAINER_PORT=8866  # <- replace with your CONTAINER_PORT if necessary
  ```
  
  You the commands to know your UID, GID
  ```bash
  id -u # UID
  id -g # GID
  ```


- docker-compose.yaml
  Change image, container_name, volumes, shm_size if needed.
  - image : name of image cached to local. if exist, load, if not, build.
  - container_name : name used to get in the container.
  - volumes : Correspondence. {local_dir}:{container_dir}
  - shm_size : shared memory size. check your spec.


- Dockerfile
  Change docker image, libraries, python version.


# Commands

- Docker compose up
  ```bash
  cd docker && docker-compose up -d
  ```
  
  If Dockerfile changed, Docker compose up with build
  ```bash
  cd docker && docker-compose up -d --build
  ```

- Execute command in Docker
  ```bash
  docker exec -it {container_name} bash
  # or
  docker exec -it -w {WORK_DIR_PATH} {container_name} bash
  ```

  As root
  ```bash
  docker exec -it -u 0 -w {WORK_DIR_PATH} {container_name} bash
  ```

- Using JupyterLab (Optional)
  ```bash
  python -m jupyterlab --ip 0.0.0.0 --port {CONTAINER_PORT} --allow-root
  ```

- Using Tensorboard
  ```bash
  tensorboard --logdir=/workspace/PytorchLightning/lightning_logs --host=0.0.0.0 --port={CONTAINER_PORT}
  # or
  python /home/{USER}/.local/lib/python3.9/site-packages/tensorboard/main.py --logdir=/workspace/PytorchLightning/lightning_logs --host=0.0.0.0 --port={CONTAINER_PORT}
  ```

- Login W & D
  ```bash
  wandb login
  # or
  python3 -m wandb login
  # or
  /usr/bin/python3 -m wandb login
  ```

# Reference
- [Ueda's Sample](https://github.com/sh1027/docker_pytorch)
