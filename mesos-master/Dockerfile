FROM ubuntu:16.04
MAINTAINER dtaniwaki

# Install

## Install the dependencies
RUN apt-get update -q \
  && apt-get install -yq openjdk-8-jre \
  curl \
  software-properties-common \
  apt-transport-https

## Install Mesos
ARG MESOS_VERSION
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF
RUN add-apt-repository "deb http://repos.mesosphere.com/ubuntu xenial main"
RUN apt-get update -q && apt-get install -y -q mesos=$MESOS_VERSION

# Clean up

## Clean up cached packages
RUN apt autoremove -y
RUN apt-get clean
RUN rm -fr /var/lib/apt/lists/*
