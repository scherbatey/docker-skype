FROM ubuntu:16.04
MAINTAINER Dmitrii Ageev <d.ageev@gmail.com>

# Set environment
ENV UNAME skype

# Install software package
RUN apt update
RUN apt install --no-install-recommends -y \
    pulseaudio-utils \
    pavucontrol \
    curl \
    libcanberra-pulse \
    libv4l-0

#RUN curl -kL -O https://repo.skype.com/latest/skypeforlinux-64.deb
COPY files/skypeforlinux-64.deb skypeforlinux-64.deb
RUN apt install -y ./skypeforlinux-64.deb

# Remove unwanted stuff
RUN rm -f skypeforlinux-64.deb
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
