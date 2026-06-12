FROM lscr.io/linuxserver/webtop:fedora-kde

USER root

# Add Google Chrome repository
RUN echo -e "[google-chrome]\n\
name=google-chrome\n\
baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64\n\
enabled=1\n\
gpgcheck=1\n\
gpgkey=https://dl.google.com/linux/linux_signing_key.pub" > /etc/yum.repos.d/google-chrome.repo

# Just update and install what you actually need
RUN dnf clean all && \
    dnf update -y && \
    dnf install -y \
        google-chrome-stable \
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
