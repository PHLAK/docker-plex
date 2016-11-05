FROM ubuntu:16.04
MAINTAINER Chris Kankiewicz <Chris@ChrisKankiewicz.com>

# Set version
ENV PLEX_VERSION 1.2.6.2975-9394c87

# Set deb URL
ENV PLEX_DEB_URL https://downloads.plex.tv/plex-media-server/${PLEX_VERSION}/plexmediaserver_${PLEX_VERSION}_amd64.deb

# Upgrade packages and install dependencies
RUN apt-get update && apt-get -y upgrade \
    && apt-get -y install avahi-utils wget \
    && rm -rf /var/lib/apt/lists/*

# Download and install the Plex Media Server deb
RUN TEMP_FILE=$(mktemp) && wget ${PLEX_DEB_URL} -O ${TEMP_FILE} \
    && dpkg -i ${TEMP_FILE} && rm ${TEMP_FILE}

# Plex environment variables
ENV PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS  6
ENV PLEX_MEDIA_SERVER_MAX_STACK_SIZE    3000
ENV PLEX_MEDIA_SERVER_TMPDIR            /tmp
ENV PLEX_MEDIA_SERVER_USER              plex
ENV LD_LIBRARY_PATH                     /usr/lib/plexmediaserver

# Define docker volumes
VOLUME /var/lib/plexmediaserver

# Expose ports
EXPOSE 32400

# Default command
CMD ["/usr/lib/plexmediaserver/Plex Media Server"]
