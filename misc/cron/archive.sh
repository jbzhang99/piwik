#!/bin/bash -e

# HOW TO SETUP THE CRONTAB JOB
# Add the following lines in your crontab file, eg. /etc/cron.d/piwik-archive
#MAILTO="youremail@example.com"
#5 0 * * * www-data /path/to/piwik/misc/cron/archive.sh > /dev/null

# OPTIMIZATION FOR HIGH TRAFFIC WEBSITE
# Please change the following settings in config/global.ini.php
#  time_before_archive_considered_outdated = 3600
#  enable_browser_archiving_triggering = false

TOKEN_AUTH="" #you can get the token_auth from the Piwik admin UI (section Users, or section API)

PHP_BIN=/usr/bin/php5
PIWIK_PATH=/home/www/piwik/demo/index.php

for period in day week year; do
  CMD="$PHP_BIN $PIWIK_PATH -- module=API&method=VisitsSummary.getVisits&idSite=all&period=$period&date=last52&format=xml&token_auth=$TOKEN_AUTH";
  $CMD
  echo ""
done
