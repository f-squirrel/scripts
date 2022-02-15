ARG base_image=ubuntu
ARG base_tag=18.04

FROM ${base_image}:${base_tag}
LABEL Description="Build dev environment"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y install curl
WORKDIR /
COPY deployment/bootstrap.sh bootstrap.sh
RUN /bin/bash bootstrap.sh -b master -r

ENV HOME /root
ENV LANG en_US.UTF-8
WORKDIR $HOME
