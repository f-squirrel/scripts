# This docker file is for testing purposes
FROM ubuntu:18.04
LABEL Description="Build dev environment"


COPY ./bootstrap.sh /bootstrap.sh

RUN ["bash", "/bootstrap.sh -b new_layout -r"]

# Need to understand why it does not work
#COPY ~/.ssh/id_rsa.pub /id_rsa.pub
#RUN ["bash", "cat >> ~/.ssh/authorized_keys"]
#RUN ["bash", "rm /id_rsa.pub"]

ENV HOME /root
WORKDIR $HOME
CMD ["/usr/bin/zsh"]
