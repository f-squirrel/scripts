ARG base_image=ubuntu
ARG base_tag=18.04

FROM ${base_image}:${base_tag}
LABEL Description="Build dev environment"

RUN  export DEBIAN_FRONTEND=noninteractive
ENV  DEBIAN_FRONTEND noninteractive


RUN apt-get update && apt-get -y install curl
WORKDIR /
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/f-squirrel/scripts/master/deployment/bootstrap.sh) -b master -r"

ENV HOME /root
WORKDIR $HOME
