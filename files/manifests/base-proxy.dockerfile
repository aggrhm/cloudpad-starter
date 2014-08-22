# vi:syntax=dockerfile

FROM phusion/baseimage:0.9.12
MAINTAINER Alan G. Graham "alan@productlab.com"

### PRIMARY PACKAGES

RUN apt-get update -q

<%= dfi :install_haproxy_153 %>

### ADDITIONAL PACKAGES

RUN apt-get install -qy git-core

<%= dfi :run, 'bin/setup_box.py', '--core' %>

### APP STUFF

ENV RACK_ENV <%= fetch(:stage) %>

### SERVICES

ADD conf/haproxy.conf.tmpl /root/conf/haproxy.conf.tmpl

### CONTAINER STUFF

ADD bin /root/bin

RUN echo "<%= container_public_key %>" >> /root/.ssh/authorized_keys

EXPOSE 80

CMD ["/sbin/my_init"]

<%= dfi :install_image_services %>
