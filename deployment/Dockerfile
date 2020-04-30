# This docker file is for testing purposes
FROM ubuntu:18.04
LABEL Description="Build dev environment"

RUN  export DEBIAN_FRONTEND=noninteractive
ENV  DEBIAN_FRONTEND noninteractive

COPY ./bootstrap.sh /bootstrap.sh

RUN /bin/bash -c "/bootstrap.sh -b new_layout -r"

# Need to understand why it does not work
#COPY ~/.ssh/id_rsa.pub /id_rsa.pub
#RUN ["bash", "cat >> ~/.ssh/authorized_keys"]
#RUN ["bash", "rm /id_rsa.pub"]

EXPOSE 22
ENV HOME /root
WORKDIR $HOME
ENTRYPOINT ["/usr/bin/zsh"]
