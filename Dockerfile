FROM fedora:32
RUN dnf -y update && dnf -y install gcc make wine mingw32-gcc git p7zip-plugins && dnf clean all
COPY init.sh /init.sh
VOLUME /srv/build
RUN mkdir -p /srv/build
ENTRYPOINT /./init.sh -DFOREGROUND
