FROM nvcr.io/nvidia/tensorflow:24.10-tf2-py3 as base

COPY start.sh start-notebook.sh start-singleuser.sh /usr/local/bin/
 
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -y upgrade && apt-get -y install tini vim tzdata sudo fakeroot locales openssh-server && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN rm -f /usr/bin/sudo; ln -sr /usr/bin/fakeroot /usr/bin/sudo
RUN rm -f /bin/sh && ln -sr /bin/bash /bin/sh
RUN rm -f /etc/ssh/ssh_host_*
RUN ln -fs /usr/share/zoneinfo/Europe/Prague /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
RUN useradd --no-log-init --create-home --shell /bin/bash --uid "1000" --no-user-group "jovyan"

RUN pip install jupyterhub
RUN rm -rf /workspace/docker-examples
RUN rm -f /usr/local/etc/jupyter/jupyter_notebook_config.py

COPY --chown=1000:100 sshd.conf /etc/ssh/sshd_config.d/sshd.conf

FROM scratch

COPY --chown=1000:100 --from=base / /

USER 1000
ENV PATH=/usr/local/mpi/bin:/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/ucx/bin:/opt/tensorrt/bin
ENV CUDA_VERSION=12.6.2.004
ENV CUDA_DRIVER_VERSION=560.35.03
ENV CUDA_CACHE_DISABLE=1
ENV NVIDIA_REQUIRE_JETPACK_HOST_MOUNTS=
ENV _CUDA_COMPAT_PATH=/usr/local/cuda/compat
ENV ENV=/etc/shinit_v2
ENV BASH_ENV=/etc/bash.bashrc
ENV SHELL=/bin/bash
ENV NVIDIA_REQUIRE_CUDA=cuda>=9.0
ENV NCCL_VERSION=2.22.3
ENV CUBLAS_VERSION=12.6.3.3
ENV CUFFT_VERSION=11.3.0.4
ENV CURAND_VERSION=10.3.7.77
ENV CUSPARSE_VERSION=12.5.4.2
ENV CUSPARSELT_VERSION=0.6.2.3
ENV CUSOLVER_VERSION=11.7.1.2
ENV CUTENSOR_VERSION=2.0.2.5
ENV NPP_VERSION=12.3.1.54
ENV NVJPEG_VERSION=12.3.3.54
ENV CUDNN_VERSION=9.5.0.50
ENV CUDNN_FRONTEND_VERSION=1.7.0
ENV TRT_VERSION=10.5.0.18
ENV TRTOSS_VERSION=
ENV NSIGHT_SYSTEMS_VERSION=2024.6.1.90
ENV NSIGHT_COMPUTE_VERSION=2024.3.2.3
ENV DALI_VERSION=1.42.0
ENV DALI_BUILD=18507157
ENV POLYGRAPHY_VERSION=0.49.13
ENV TRANSFORMER_ENGINE_VERSION=1.11
ENV MODEL_OPT_VERSION=0.17.0
ENV LD_LIBRARY_PATH=/usr/local/cuda/extras/CUPTI/lib64:/usr/local/cuda/compat/lib:/usr/local/nvidia/lib:/usr/local/nvidia/lib64
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility,video
ENV NVIDIA_PRODUCT_NAME=TensorFlow
ENV GDRCOPY_VERSION=2.3.1-1
ENV HPCX_VERSION=2.20
ENV MOFED_VERSION=5.4-rdmacore39.0
ENV OPENUCX_VERSION=1.17.0
ENV OPENMPI_VERSION=4.1.7
ENV RDMACORE_VERSION=39.0
ENV OPAL_PREFIX=/opt/hpcx/ompi
ENV OMPI_MCA_coll_hcoll_enable=0
ENV LIBRARY_PATH=/usr/local/cuda/lib64/stubs:
ENV NVIDIA_BUILD_ID=114411264
ENV TENSORFLOW_VERSION=2.16.1
ENV NVIDIA_TENSORFLOW_VERSION=24.10-tf2
ENV PYVER=3.10
ENV TF_PYTHON_VERSION=3.10
ENV PYTHONIOENCODING=utf-8
ENV LC_ALL=en_US.UTF-8
ENV PIP_DEFAULT_TIMEOUT=100
ENV PIP_DISABLE_PIP_VERSION_CHECK=1
ENV BAZELRC=/home/jovyan/.bazelrc
ENV JUPYTER_PORT=8888
ENV TENSORBOARD_PORT=6006
ENV TENSORBOARD_DEBUGGER_PORT=6064
ENV TF_AUTOTUNE_THRESHOLD=2
ENV TF_USE_CUDNN_BATCHNORM_SPATIAL_PERSISTENT=1
ENV CUDA_MODULE_LOADING=LAZY
ENV XLA_FLAGS=--xla_gpu_enable_triton_gemm=false
ENV TF_USE_LEGACY_KERAS=1
ENV HOME=/home/jovyan

WORKDIR /home/jovyan
ENTRYPOINT ["tini", "-g", "--"]
CMD ["start-notebook.sh"]
