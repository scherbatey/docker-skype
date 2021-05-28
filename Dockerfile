FROM ubuntu:latest

RUN cat /etc/lsb-release

# Set environment
ENV APPLICATION "skype"
ENV VERSION 8.11.0.4
ENV EXECUTABLE "/usr/share/skypeforlinux/skypeforlinux"

# Install software package
RUN apt-get update
RUN apt-get install --no-install-recommends -y \
    pulseaudio-utils \
    pavucontrol \
    curl \
    sudo \
    libcanberra-pulse \
    libv4l-0\ 
    apt-transport-https\
    ca-certificates \
    gnupg

RUN echo "deb [arch=amd64] https://repo.skype.com/deb stable main" | tee /etc/apt/sources.list.d/skypeforlinux.list

RUN curl https://repo.skype.com/data/SKYPE-GPG-KEY | apt-key add -
RUN apt-get update

RUN apt-get install --no-install-recommends -y skypeforlinux

# Copy pulse audio settings
COPY files/pulse-client.conf /etc/pulse/client.conf
COPY files/wrapper /sbin/wrapper
COPY files/entrypoint.sh /sbin/entrypoint.sh
COPY files/security_profile.json /tmp/security_profile.json

ENTRYPOINT ["/sbin/entrypoint.sh"]
