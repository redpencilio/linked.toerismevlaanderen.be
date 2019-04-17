#!/bin/bash
cd /home/tvladmin/linked.toerismevlaanderen.be/scripts

KEEP_NB_OF_FILES=10
FILES_DIR=../data/files/*

# Restart services
/usr/local/bin/docker-compose restart database resource import

# Cleanup output files
ls -d -1tr $FILES_DIR | head -n -$KEEP_NB_OF_FILES | xargs -d '\n' rm -f
