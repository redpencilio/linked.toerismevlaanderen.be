#!/bin/bash
KEEP_NB_OF_FILES=10
FILES_DIR=../data/files/*

drc=`which docker-compose`
if [ $? -ne 0 ]; then
    echo "ERROR: could not find docker executable";
    exit -1;
fi

# Restart services
$drc restart database resource import

# Cleanup output files
ls -d -1tr $FILES_DIR | head -n -$KEEP_NB_OF_FILES | xargs -d '\n' rm -f
