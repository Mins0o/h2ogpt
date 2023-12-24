# devel needed for bitsandbytes requirement of libcudart.so, otherwise runtime sufficient
FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive

ENV PATH="/h2ogpt_conda/bin:${PATH}"
ARG PATH="/h2ogpt_conda/bin:${PATH}"

ENV HOME=/workspace
ENV CUDA_HOME=/usr/local/cuda-11.8
ENV VLLM_CACHE=/workspace/.vllm_cache
ENV TIKTOKEN_CACHE_DIR=/workspace/tiktoken_cache

WORKDIR /workspace

ARG user=h2ogpt
ARG group=h2ogpt
ARG uid=1000
ARG gid=1000

RUN groupadd -g ${gid} ${group} && useradd -u ${uid} -g ${group} -s /bin/bash ${user}

COPY --chown=h2ogpt ./docs /workspace/docs
COPY --chown=h2ogpt ./requirements.txt /workspace/requirements.txt
COPY --chown=h2ogpt ./reqs_optional /workspace/reqs_optional
COPY --chown=h2ogpt ./Makefile /workspace/Makefile
COPY --chown=h2ogpt ./version.txt /workspace/version.txt
COPY --chown=h2ogpt ./docker_build_script_ubuntu.sh /workspace/docker_build_script_ubuntu.sh

RUN cd /workspace && ./docker_build_script_ubuntu.sh 

COPY --chown=h2ogpt . /workspace/

USER h2ogpt

ENTRYPOINT ["python3.10"]
