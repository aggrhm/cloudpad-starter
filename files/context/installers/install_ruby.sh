#!/bin/bash

apt-get install -qy gawk build-essential libreadline6-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake bison libffi-dev libxslt-dev libxml2-dev

curl -L $1 | tar -zxf - -C /tmp/
cd /tmp/ruby-* && ./configure && make && make install && cd && rm -rf /tmp/ruby-* && gem install bundler
