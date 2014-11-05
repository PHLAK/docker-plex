#!/usr/bin/env bash


## PLEX ENVIRONMENT VARIABLES
########################################

## Number of plugins that can run at the same time
export PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS="6"

## ulimit -s $PLEX_MEDIA_SERVER_MAX_STACK_SIZE
export PLEX_MEDIA_SERVER_MAX_STACK_SIZE="3000"

## Where the mediaserver should store the transcodes
export PLEX_MEDIA_SERVER_TMPDIR="/tmp"

## The user that PMS should run as,
export PLEX_MEDIA_SERVER_USER="plex"

## Set Plex library path
export LD_LIBRARY_PATH="/usr/lib/plexmediaserver"


## SCRIPT ACTIONS
########################################

## Run plex
exec "/usr/lib/plexmediaserver/Plex Media Server"
