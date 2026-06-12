FROM lscr.io/linuxserver/webtop:fedora-kde

# Switch to root to manage system packages
USER root

# 1. Add the Google Chrome official repository
RUN echo -e "[google-chrome]\n\
name=google-chrome\n\
baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64\n\
enabled=1\n\
gpgcheck=1\n\
gpgkey=https://dl.google.com/linux/linux_signing_key.pub" > /etc/yum.repos.d/google-chrome.repo

# 2. Clean cache, remove default browsers, and install required packages in a single layer
RUN dnf clean all && \
    dnf update -y && \
    # Remove default Firefox and Chromium if they exist (ignore errors if already missing)
    (dnf remove -y firefox chromium || true) && \
    # Install the requested toolset
    dnf install -y \
        google-chrome-stable \
        spectacle \
        ark \
        plasma-browser-integration \
        kate \
        ping \
        nano \
        fuse-libs && \
    dnf clean all

# No need to revert USER; the linuxserver base image handles user privileges via s6-overlay on container boot
