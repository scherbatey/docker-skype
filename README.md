# skype
Docker container to run Skype - text, voice and video communication software.

# Usage

The wrapper scripts volume mount the X11 and pulseaudio sockets in the launcher container. The X11 socket allows for the user interface display on the host, while the pulseaudio socket allows for the audio output to be rendered on the host.

When the image is launched the following directories are mounted as volumes

    Container		Host
--------------------------------------------
    ${HOME}/.skype	~/.skype
    ${HOME}/.config	~/.skype/.config
    ${HOME}/.local	~/.skype/.local
    ${HOME}/.pki	~/.skype/.pki
    ${HOME}/Downloads	~/Downloads

This makes sure that your profile details are stored on the host and files received are available on your host in the appropriate download directory.

To launch Skype in a container use the wrapper script. For example, after installation skype command will launch Skype inside a Docker container regardless of whether it is installed on the host or not.


# Installation

With the image locally available, install the wrapper scripts using:

```
docker run -it --rm --volume ~/bin/:/target dmitriiageev/skype install
```

This will install a wrapper script to launch skype.


# Uninstallation

```
docker run -it --rm --volume ~/bin:/target dmitriiageev/skype uninstall
```

# Note
This docker image supports audio playback with PULSEAUDIO through a runtime dir mount.

GitHub Page: https://github.com/dmitrii-ageev/skype
Docker Hub Page: https://hub.docker.com/r/dmitriiageev/skype
