ARG BASE_IMAGE=${BASE_IMAGE}
FROM ${BASE_IMAGE}

ARG USER_NAME=docker
ARG GROUP_NAME=dockers
ARG UID=1000
ARG GID=1000
ARG PASSWORD=${USER_NAME}
ARG WORKDIR=/home/${USER_NAME}/workspace

ENV DEBIAN_FRONTEND="noninteractive"
ENV PYTHONPATH=${WORKDIR}

RUN apt-get update && apt-get install -y \
    sudo zip unzip ffmpeg cmake wget vim screen \
    git curl ssh openssh-client libopencv-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y software-properties-common
ARG PYTHON_VERSION=${PYTHON_VERSION}
RUN add-apt-repository -y 'ppa:deadsnakes/ppa' \
    && apt-get update && apt-get install -y \
    python${PYTHON_VERSION} python${PYTHON_VERSION}-dev python${PYTHON_VERSION}-distutils python${PYTHON_VERSION}-tk \
    python3-pip python-is-python3 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Change default python3 version
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python${PYTHON_VERSION}
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python${PYTHON_VERSION} 1 \
    && update-alternatives --set python3 /usr/bin/python${PYTHON_VERSION} \
    && python3 -m pip install --upgrade pip setuptools \
    && rm -rf /var/lib/apt/lists/*

# Add user with sudo
RUN groupadd -g ${GID} ${GROUP_NAME} && \
    useradd -m -s /bin/bash -u ${UID} -g ${GID} -G sudo ${USER_NAME} && \
    echo ${USER_NAME}:${PASSWORD} | chpasswd

USER ${USER_NAME}
WORKDIR ${WORKDIR}

ENV PATH=$PATH:/home/container/.local/bin

# # Install other libraries
# COPY requirements.txt ${WORKDIR}
# RUN python3 -m pip install -r requirements.txt \
#     && rm -rf /var/lib/apt/lists/*
