# This docker file is for testing purposes
FROM ubuntu:18.04
LABEL Description="Build dev environment"

RUN  export DEBIAN_FRONTEND=noninteractive
ENV  DEBIAN_FRONTEND noninteractive


RUN apt-get update && apt-get -y install curl
WORKDIR /
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/f-squirrel/scripts/master/deployment/bootstrap.sh) -b master -r"

EXPOSE 22
ENV HOME /root
WORKDIR $HOME
ENTRYPOINT ["/usr/bin/zsh"]
