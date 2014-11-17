# vi:syntax=dockerfile

FROM phusion/baseimage:0.9.12
MAINTAINER Alan G. Graham "alan@productlab.com"

### PRIMARY PACKAGES

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10

RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/10gen.list

RUN apt-get update -q && apt-get install -qy mongodb-org=2.6.1 mongodb-org-server=2.6.1 mongodb-org-shell=2.6.1 mongodb-org-mongos=2.6.1 mongodb-org-tools=2.6.1

<%= dfi :configure_basic_container %>

### CONTAINER STUFF

ADD bin /root/bin

<%= dfi :install_container_key %>

EXPOSE 27017

CMD ["/sbin/my_init"]

<%= dfi :install_image_services %>
