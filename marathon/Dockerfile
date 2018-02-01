FROM ubuntu:16.04
MAINTAINER dtaniwaki

# Install

## Install the dependencies
RUN echo "deb http://repos.mesosphere.io/ubuntu/ trusty main" > /etc/apt/sources.list.d/mesosphere.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF
RUN apt-get update -q \
  && apt-get install -yq mesos \
  python-software-properties \
  curl \
  default-jdk \
  software-properties-common \
  apt-transport-https

## Install Marathon
ARG MARATHON_VERSION
RUN curl http://downloads.mesosphere.com/marathon/v$MARATHON_VERSION/marathon-$MARATHON_VERSION.tgz > /tmp/marathon.tgz
RUN mkdir -p /opt/marathon && tar xzf /tmp/marathon.tgz -C /opt/marathon --strip=1 && rm -f /tmp/marathon.tgz

# Clean up

## Clean up cached packages
RUN apt autoremove -y
RUN apt-get clean

# Misc
EXPOSE 8080
WORKDIR /opt/marathon
CMD ["--help"]
ENTRYPOINT ["/opt/marathon/bin/marathon"]
