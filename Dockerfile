FROM ghcr.io/linuxserver/baseimage-selkies:fedora44

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Custom version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# title
ENV TITLE="Fedora KDE" \
    PIXELFLUX_WAYLAND=true

RUN \
  echo "**** add icon ****" && \
  curl -o \
    /usr/share/selkies/www/icon.png \
    https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/webtop-logo.png && \
  echo "**** install packages ****" && \
  dnf install -y --setopt=install_weak_deps=False --best \
    breeze-icon-theme \
    cargo \
    dolphin \
    kde-gtk-config \
    kde-settings-pulseaudio \
    kde-wallpapers \
    kdialog \
    kfind \
    kmenuedit \
    konsole5 \
    kwrite \
    plasma-breeze \
    plasma-desktop \
    plasma-systemmonitor \
    plasma-workspace-xorg \
    qt5-qtscript && \
  cargo install \
    wl-clipboard-rs-tools && \
  echo "**** replace wl-clipboard with rust ****" && \
  mv \
    /config/.cargo/bin/wl-* \
    /usr/bin/ && \
  echo "**** application tweaks ****" && \
  setcap -r \
    /usr/sbin/kwin_wayland && \
  echo "**** kde tweaks ****" && \
  rm -f \
    /etc/xdg/autostart/at-spi-dbus-bus.desktop \
    /etc/xdg/autostart/gmenudbusmenuproxy.desktop \
    /etc/xdg/autostart/polkit-kde-authentication-agent-1.desktop \
    /etc/xdg/autostart/powerdevil.desktop && \
  echo "**** cleanup ****" && \
  dnf autoremove -y && \
  dnf clean all && \
  rm -rf \
    /config/.cargo \
    /config/.cache \
    /tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000
VOLUME /config

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
