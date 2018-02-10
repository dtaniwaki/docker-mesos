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

# Set up dind
RUN apt-get update -q && apt-get install -yq sudo
RUN set -x \
  && addgroup --system dockremap \
  && adduser --system --ingroup dockremap dockremap \
  && echo 'dockremap:165536:65536' >> /etc/subuid \
  && echo 'dockremap:165536:65536' >> /etc/subgid
ARG DIND_COMMIT=3b5fac462d21ca164b3778647420016315289034
RUN set -ex \
  && curl -fsSL -o /usr/local/bin/dind "https://raw.githubusercontent.com/docker/docker/${DIND_COMMIT}/hack/dind" \
  && chmod +x /usr/local/bin/dind
COPY docker-entrypoint.sh /usr/local/bin/
ENV DOCKERD_OPTIONS=

# Clean up

## Clean up cached packages
RUN apt autoremove -y \
  && apt-get clean \
  && rm -fr /var/lib/apt/lists/*

# Misc
# Create anonymous user
ARG USER_NAME=anonymous
ARG USER_UID=1000
RUN adduser --system --no-create-home --disabled-password --gecos "" --uid $USER_UID $USER_NAME
RUN addgroup $USER_NAME docker

# Define docker store as a volume to avoid error of unarchiving Docker images by tar command on OverlayFS.
#   https://github.com/docker/hub-feedback/issues/727
VOLUME /tmp/mesos/store/docker
VOLUME /var/lib/docker
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mesos-slave"]
