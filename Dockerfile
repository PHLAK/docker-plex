FROM ubuntu:14.04
MAINTAINER Chris Kankiewicz <Chris@ChrisKankiewicz.com>

## Set version
ENV VERSION 0.9.11.6.800-831ffad

## Install Plex dependencies
RUN apt-get update && apt-get -y upgrade && apt-get -y install avahi-utils wget

## Download and install the Plex Media Server deb
RUN wget https://downloads.plex.tv/plex-media-server/${VERSION}/plexmediaserver_${VERSION}_amd64.deb -O /tmp/plexmediaserver.deb
RUN dpkg -i /tmp/plexmediaserver.deb

## Increase max file watches
ADD files/60-max-file-watches.conf /etc/sysctl.d/60-max-file-watches.conf

## Perform apt cleanup
RUN apt-get -y autoremove && apt-get -y clean && apt-get -y autoclean

## Add and chmod the run file
ADD files/run.sh /run.sh
RUN chmod +x /run.sh

## Define docker volumes
VOLUME /srv/media /var/lib/plexmediaserver

## Expose ports
EXPOSE 32400

## Default command
CMD ["/run.sh"]
