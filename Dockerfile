FROM ubuntu:16.04
MAINTAINER Dmitrii Ageev <d.ageev@gmail.com>

# Set environment
ENV UNAME skype

ENV VERSION 8.11.0.4
ENV FILE "skypeforlinux_${VERSION}_amd64.deb"
ENV LINK "https://repo.skype.com/deb/pool/main/s/skypeforlinux/${FILE}"

# Install software package
RUN apt update
RUN apt install --no-install-recommends -y \
    pulseaudio-utils \
    pavucontrol \
    curl \
    libcanberra-pulse \
    libv4l-0

RUN curl -kL -O "${LINK}"
RUN apt install -y ./${FILE}

# Remove unwanted stuff
RUN rm -f ${FILE}
RUN apt purge -y --auto-remove curl

# Copy pulse audio settings
COPY files/pulse-client.conf /etc/pulse/client.conf

# Create a user
RUN groupadd -g 1000 $UNAME
RUN useradd -u 1000 -g 1000 -G audio,video -m $UNAME

# Run a software
USER $UNAME

ENV PULSE_LATENCY_MSEC 30
CMD /usr/share/skypeforlinux/skypeforlinux
