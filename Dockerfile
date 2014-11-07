FROM ubuntu:14.04
MAINTAINER Chris Kankiewicz <Chris@ChrisKankiewicz.com>

## Install Plex dependencies
RUN apt-get update && apt-get -y upgrade && apt-get -y install avahi-utils

## Download and install the Plex Media Server deb
ADD https://downloads.plex.tv/plex-media-server/0.9.11.1.678-c48ffd2/plexmediaserver_0.9.11.1.678-c48ffd2_amd64.deb /tmp/plexmediaserver.deb
RUN dpkg -i /tmp/plexmediaserver.deb

## Increase max file watches
ADD file/60-max-file-watches.conf /etc/sysctl.d/60-max-file-watches.conf

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
