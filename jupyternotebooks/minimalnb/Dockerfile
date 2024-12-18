FROM jupyter/minimal-notebook:hub-4.0.2 as base

USER root
RUN apt-get update && apt-get -y dist-upgrade && apt-get install -y fakeroot dumb-init vim less nano && apt-get clean && rm -rf /var/lib/apt/lists/*
# Make sudo working
RUN rm -f /usr/bin/sudo; ln -sr /usr/bin/fakeroot /usr/bin/sudo
# Set default shell to bash
RUN rm -f /bin/sh && ln -sr /bin/bash /bin/sh
RUN conda install --quiet --yes nb_conda_kernels

# Create new image from scratch
FROM scratch

# kaniko runner compatible, for docker, it is sufficent to replace all 
# the copy commands by single one: COPY --chown=1000:100 --from=base / / 
COPY --chown=1000:100 --from=base  /bin /bin
COPY --chown=1000:100 --from=base  /sbin /sbin
COPY --chown=1000:100 --from=base  /lib64 /lib64
COPY --chown=1000:100 --from=base  /libx32 /libx32
COPY --chown=1000:100 --from=base  /lib /lib
COPY --chown=1000:100 --from=base  /boot /boot
COPY --chown=1000:100 --from=base  /etc /etc
COPY --chown=1000:100 --from=base  /home /home
COPY --chown=1000:100 --from=base  /opt /opt
COPY --chown=1000:100 --from=base  /root /root
COPY --chown=1000:100 --from=base  /tmp /tmp
COPY --chown=1000:100 --from=base  /usr /usr
COPY --chown=1000:100 --from=base  /var /var

USER 1000

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV PATH=$PATH:/opt/conda/bin
ENV LD_LIBRARY_PATH=/opt/conda/lib

WORKDIR /home/jovyan

# Required for GPU
RUN mkdir -p /usr/share/glvnd/egl_vendor.d /usr/share/egl/egl_external_platform.d /etc/vulkan/icd.d /etc/vulkan/implicit_layer.d

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ENV XDG_CACHE_HOME="/home/${NB_USER}/.cache/"
ENV XLA_FLAGS=--xla_gpu_cuda_data_dir=/opt/conda/lib
ENV PS1 '\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
ENV PS2 '> '
ENV PS4 '+ '
ENTRYPOINT ["dumb-init"]
CMD ["start-notebook.sh"]
