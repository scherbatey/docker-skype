FROM ubuntu:16.04
MAINTAINER Dmitrii Ageev <d.ageev@gmail.com>

# Set environment
ENV APPLICATION "skype"
ENV VERSION 8.11.0.4
ENV FILE "skypeforlinux_${VERSION}_amd64.deb"
ENV LINK "https://repo.skype.com/deb/pool/main/s/skypeforlinux/${FILE}"
ENV EXECUTABLE "/usr/share/skypeforlinux/skypeforlinux"

# Install software package
RUN apt update
RUN apt install --no-install-recommends -y \
    pulseaudio-utils \
    pavucontrol \
    curl \
    sudo \
    libcanberra-pulse \
    libv4l-0

RUN curl -kL -O "${LINK}"
RUN apt install -y ./${FILE}

# Remove unwanted stuff
RUN rm -f ${FILE}
RUN apt purge -y --auto-remove curl

# Copy pulse audio settings
COPY files/pulse-client.conf /etc/pulse/client.conf
COPY files/wrapper /sbin/wrapper
COPY files/entrypoint.sh /sbin/entrypoint.sh

ENTRYPOINT ["/sbin/entrypoint.sh"]
