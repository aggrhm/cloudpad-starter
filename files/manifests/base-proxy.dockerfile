# vi:syntax=dockerfile

FROM phusion/baseimage:0.9.12
MAINTAINER Alan G. Graham "alan@productlab.com"

### PRIMARY PACKAGES

RUN apt-get update -q

<%= dfi :install_haproxy_153 %>

### ADDITIONAL PACKAGES

RUN apt-get install -qy git-core

<%= dfi :configure_basic_container %>

### APP STUFF

ENV RACK_ENV <%= fetch(:stage) %>

### SERVICES

ADD conf/haproxy.conf.tmpl /root/conf/haproxy.conf.tmpl

### CONTAINER STUFF

ADD bin /root/bin

<%= dfi :install_container_key %>

EXPOSE 80

CMD ["/sbin/my_init"]

<%= dfi :install_image_services %>
