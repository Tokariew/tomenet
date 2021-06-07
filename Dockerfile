FROM registry.fedoraproject.org/fedora-minimal:34
RUN microdnf -y install gcc make wine.i686 mingw32-gcc git p7zip-plugins --nodocs --setopt install_weak_deps=0 && microdnf clean all -y
COPY init.sh /init.sh
VOLUME /srv/build
RUN mkdir -p /srv/build
COPY patches /patches
ENTRYPOINT ["/init.sh"]
ARG CACHEBUST
RUN microdnf -y update && microdnf clean all

