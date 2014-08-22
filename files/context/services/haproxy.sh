#!/bin/bash

# update conf with app servers (/root/haproxy.conf)

# launch haproxy
haproxy -f /root/conf/haproxy.conf
