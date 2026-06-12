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

# LAYER 2: Install ONLY Google Chrome
# This layer is heavy (~600MB) but it will be cached and "frozen"
RUN dnf clean all && \
    dnf update -y && \
    dnf install -y google-chrome-stable && \
    dnf clean all

# LAYER 3: Install your lightweight utility packages
# If you add or remove packages here, ONLY this layer will re-build.
# Chrome will be pulled instantly from the cache!
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
        fuse-libs && \
    dnf clean all
