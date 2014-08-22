#!/bin/bash
cd /app && bundle exec script/job_processor -D -e $RACK_ENV start
