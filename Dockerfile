FROM nvidia/cuda:12.1.1-runtime-ubuntu22.04 as base

RUN apt-get update && apt-get install -y sudo 

ARG USERNAME=kato
ARG GROUPNAME=docker
ARG UID=1000
ARG GID=1000
ARG PASSWORD=kato-docker-pw
RUN groupadd -g $GID $GROUPNAME && \
    useradd -m -s /bin/bash -u $UID -g $GID -G sudo $USERNAME && \
    echo $USERNAME:$PASSWORD | chpasswd && \
    echo "$USERNAME   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER $USERNAME
WORKDIR /home/kato/ReinforcementLearning/program
COPY requirements.txt /home/kato/ReinforcementLearning/program

RUN sudo apt-get install -y python3 python3-pip
RUN pip3 install torch torchvision torchaudio
RUN pip3 install -r /home/kato/ReinforcementLearning/program/requirements.txt

