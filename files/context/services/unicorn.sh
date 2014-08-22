#!/bin/bash
cd /app && bundle exec unicorn -c /root/conf/unicorn.rb
