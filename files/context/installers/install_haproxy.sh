#!/bin/bash

apt-get install -qy build-essential make g++ libssl-dev
curl -L $1 | tar -zxf - -C /tmp/
cd /tmp/haproxy-* && make USE_OPENSSL=1 TARGET=generic && make install && cd && rm -rf /tmp/haproxy-*
