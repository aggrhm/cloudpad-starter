# vi:syntax=dockerfile

FROM phusion/baseimage:0.9.12
MAINTAINER Alan G. Graham "alan@productlab.com"

### PRIMARY PACKAGES

RUN apt-get update -q

<%= dfi :install_ruby_200 %>

### ADDITIONAL PACKAGES

RUN apt-get install -qy git-core imagemagick libmagickcore-dev libmagickwand-dev nginx

<%= dfi :install_image_gemfiles %>

<%= dfi :run, 'bin/setup_box.py', '--core' %>


### APP STUFF

ENV RACK_ENV <%= fetch(:stage) %>

<%= dfi :install_image_repos %>

### CONF

ADD conf/unicorn.rb /root/conf/unicorn.rb
ADD conf/nginx.conf /etc/nginx/nginx.conf


### CONTAINER STUFF
ADD bin /root/bin
RUN echo "<%= container_public_key %>" >> /root/.ssh/authorized_keys

<% if image_opts[:ports] %>
EXPOSE <%= image_opts[:ports][:app][:cport] %>
<% end %>

CMD ["/sbin/my_init"]

<%= dfi :install_image_services %>
