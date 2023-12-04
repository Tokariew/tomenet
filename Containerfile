FROM registry.fedoraproject.org/fedora-minimal:39
RUN dnf5 -y install gcc make wine.i686 mingw32-{gcc,libgnurx} git p7zip-plugins --nodocs --setopt install_weak_deps=0 && dnf5 clean all -y
COPY init.sh /init.sh
VOLUME /srv/build
RUN mkdir -p /srv/build
COPY patches /patches
ENTRYPOINT ["/init.sh"]
ARG CACHEBUST
RUN dnf5 -y upgrade && dnf5 clean all
