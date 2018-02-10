FROM ubuntu:16.04
MAINTAINER dtaniwaki

# Install

## Install the dependencies
RUN apt-get update -q \
  && apt-get install -yq openjdk-8-jre \
  curl \
  software-properties-common \
  apt-transport-https

## Install Docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"
RUN apt-get update -q && apt-get install -y -q docker-ce=17.12.0~ce-0~ubuntu

## Install Mesos
ARG MESOS_VERSION
ENV MESOS_SYSTEMD_ENABLE_SUPPORT false
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF
RUN add-apt-repository "deb http://repos.mesosphere.com/ubuntu xenial main"
RUN apt-get update -q && apt-get install -y -q mesos=$MESOS_VERSION

# Clean up

## Clean up cached packages
RUN apt autoremove -y
RUN apt-get clean
RUN rm -fr /var/lib/apt/lists/*

# Misc
# Create anonymous user
ARG USER_NAME=anonymous
ARG USER_UID=1000
RUN adduser --system --no-create-home --disabled-password --gecos "" --uid $USER_UID $USER_NAME

# Define docker store as a volume to avoid error of unarchiving Docker images by tar command on OverlayFS.
#   https://github.com/docker/hub-feedback/issues/727
