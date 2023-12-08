#!/bin/bash
# Set up an inotify listener for a directory and copy the directory's CONTENT 
# to a remote location using scp
# Usage uureplacement.sh <outbox_dir> <user@servername:>
# Example
# ./uureplacement outbodir user@servername:/tmp/
# Will place the files within outboxdir into /tmp/sourcehostname on the destination

inotifywait -m -r -e delete,moved_to,moved_from,close_write \
    --format "%e %w%f" $1|
while read filepath; do
    echo $filepath was changed
    rsync -vazc ${1}/ ${2}$(hostname)
done
