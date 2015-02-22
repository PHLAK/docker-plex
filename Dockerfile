FROM ubuntu:14.04
MAINTAINER Chris Kankiewicz <Chris@ChrisKankiewicz.com>

## Set version
ENV VERSION 0.9.11.7.803-87d0708

## Upgrade packages and install dependencies
RUN apt-get update && apt-get -y upgrade \
    && apt-get -y install avahi-utils wget \
    && rm -rf /var/lib/apt/lists/*

## Download and install the Plex Media Server deb
RUN wget https://downloads.plex.tv/plex-media-server/${VERSION}/plexmediaserver_${VERSION}_amd64.deb -O /tmp/plexmediaserver.deb \
    && dpkg -i /tmp/plexmediaserver.deb \
    && rm /tmp/plexmediaserver.deb

## Increase max file watches
ADD files/60-max-file-watches.conf /etc/sysctl.d/60-max-file-watches.conf

## Add and chmod the run file
ADD files/run.sh /run.sh
RUN chmod +x /run.sh

## Define docker volumes
VOLUME /srv/media /var/lib/plexmediaserver

## Expose ports
EXPOSE 32400

## Default command
CMD ["/run.sh"]
