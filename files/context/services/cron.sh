#!/bin/bash
cd /app && bundle exec script/cron -D -e $RACK_ENV start
