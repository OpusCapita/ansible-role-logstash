#!/bin/bash -e

DAYS_ARCHIVE=7
DAYS_DELETE=30

LAST_DATE=$(
  ls /data/logs/ |
  egrep [0-9]{4}\.[0-9]{2}.[0-9]{2} |
  tr / " " |
  tr . - |
  sort |
  tail -n 1
)

ls /data/logs/ |
egrep [0-9]{4}\.[0-9]{2}.[0-9]{2} |
tr / " " |
tr . - |
{
  while read f; do
    [ "$(( $(date -d"$LAST_DATE" +%s) - $(date -d"$f" +%s) ))" -gt "$(( $DAYS_ARCHIVE*24*60*60 ))" ] && echo mv -v /data/logs/$f /data/archive/$f
  done
}

ls /data/logs/ |
egrep [0-9]{4}\.[0-9]{2}.[0-9]{2} |
tr / " " |
tr . - |
{
  while read f; do
    [ "$(( $(date -d"$LAST_DATE" +%s) - $(date -d"$f" +%s) ))" -gt "$(( $DAYS_DELETE*24*60*60 ))" ] && echo rm -rf /data/logs/$f
  done
}
