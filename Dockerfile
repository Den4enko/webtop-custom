FROM lscr.io/linuxserver/webtop:fedora-kde

# Switch to root to manage system packages
USER root

# LAYER 1: Add Google Chrome repository (extremely lightweight, acts as a base)
RUN echo -e "[google-chrome]\n\
name=google-chrome\n\
baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64\n\
enabled=1\n\
gpgcheck=1\n\
gpgkey=https://dl.google.com/linux/linux_signing_key.pub" > /etc/yum.repos.d/google-chrome.repo

# Google Chrome
RUN dnf clean all && \
    dnf update -y && \
    dnf install -y google-chrome-stable && \
    dnf clean all

RUN dnf clean all && \
    dnf update -y && \
    dnf install -y pipewire-jack-audio-connection-kit xournalpp && \
    dnf clean all

# Other Custom Packages
RUN dnf clean all && \
    dnf install -y \
        spectacle \
        ark \
        plasma-browser-integration \
        kate \
        ping \
        fastfetch \
        htop \
        nano \
        tree \
        rclone \
        fuse-libs && \
    dnf clean all
