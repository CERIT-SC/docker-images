FROM cerit.io/os/ubuntu:22.04-user

ARG CUDA=11-8

COPY --chown=1000:1000 libnvidia-compute-535_535.161.07-0ubuntu3_amd64.deb /tmp/libnvidia-compute-535_535.161.07-0ubuntu3_amd64.deb
RUN sudo dpkg -i /tmp/libnvidia-compute-535_535.161.07-0ubuntu3_amd64.deb && rm /tmp/libnvidia-compute-535_535.161.07-0ubuntu3_amd64.deb
RUN apt-get update && sudo apt-get -y install --no-install-recommends wget ca-certificates && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN cd /tmp; wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb && sudo dpkg -i cuda-keyring_1.1-1_all.deb 
COPY --chown=1000:1000 cuda.repo /etc/apt/sources.list.d/cuda.repo
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && fakeroot apt-get -y install --no-install-recommends cuda-toolkit-${CUDA} libc-devtools build-essential gdb git flex bison automake autoconf vim curl openssh-client python3-pip python3-venv  && apt-get clean && rm -rf /var/lib/apt/lists/*
COPY --chown=1000:1000 start-notebook.sh /usr/local/bin/
RUN mv /home/ubuntu /home/jovyan && ln -s /home/jovyan /home/ubuntu
RUN pip3 install --no-cache-dir jupyterlab jupyterhub ipywidgets widgetsnbextension notebook && rm -rf ~/.cache
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
