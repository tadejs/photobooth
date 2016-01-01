#!/bin/bash
## watch a directory for new .JPG files, kill previously displayed ones, and show new
#
# show the most recent file to start
skill eog
export CURRENT_PHOTO_FILE=`ls -t montages/*.jpg|head -n 1`
eog -g $CURRENT_PHOTO_FILE &

while inotifywait --exclude tmp* --format \%f -e close_write montages
do
  skill eog
  export CURRENT_PHOTO_FILE=`ls -t montages/*.jpg|head -n 1`
  eog -g $CURRENT_PHOTO_FILE &
done
