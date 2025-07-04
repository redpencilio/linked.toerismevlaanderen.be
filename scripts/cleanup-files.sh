#!/bin/bash
cd /data/linked.toerismevlaanderen.be/scripts

KEEP_NB_OF_FILES=100
FILES_DIR=../data/files/*

# Restart services
/usr/bin/docker compose restart triplestore resource

# Cleanup output files
ls -d -1tr $FILES_DIR | head -n -$KEEP_NB_OF_FILES | xargs -d '\n' rm -f
