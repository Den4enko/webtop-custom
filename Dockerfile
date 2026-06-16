FROM lscr.io/linuxserver/webtop:fedora-kde

# Switch to root to manage system packages
USER root

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
        flatpak \
        fuse-libs && \
    dnf clean all

ENV XDG_DATA_DIRS="/usr/local/share:/usr/share:/config/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share"
