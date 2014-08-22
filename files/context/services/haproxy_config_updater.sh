#!/bin/bash

/root/bin/pyconfd -t /root/conf/haproxy.conf.tmpl -s haproxy -k USR1 -a $APP_KEY

# 30 second interval implied
# default docker port implied
# key of "containers" implied
