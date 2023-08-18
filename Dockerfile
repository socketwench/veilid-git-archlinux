FROM archlinux
MAINTAINER socketwench@deninet.com

RUN pacman -Syyu --noconfirm base-devel git rust capnproto protobuf && \
    useradd -m -s /bin/bash veilid
    
COPY PKGBUILD /home/veilid/PKGBUILD
COPY systemd-sysusers.conf /home/veilid/systemd-sysusers.conf

USER veilid
WORKDIR /home/veilid
RUN makepkg

USER root
RUN pacman -U --noconfirm /home/veilid/veilid-git-*.pkg.tar.zst
