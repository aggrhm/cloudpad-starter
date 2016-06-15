require 'fileutils'

namespace :starter do

  task :load do
    set(:dockerfile_helpers, {
      install_ruby: lambda {|tar|
        str = ""
        str << "RUN apt-get install -qy gawk build-essential libreadline6-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake bison libffi-dev libxslt-dev libxml2-dev\n"
        str << "RUN curl -L #{tar} | tar -zxf - -C /tmp/\n"
        str << "RUN cd /tmp/ruby-* && ./configure && make && make install && cd && rm -rf /tmp/ruby-* && gem install bundler\n"
        str
      },
      install_haproxy: lambda {|tar|
        str = ""
        str << "RUN apt-get install -qy build-essential make g++ libssl-dev\n"
        str << "RUN curl -L #{tar} | tar -zxf - -C /tmp/\n"
        str << "RUN cd /tmp/haproxy-* && make USE_OPENSSL=1 TARGET=generic && make install && cd && rm -rf /tmp/haproxy-*\n"
        str
      },
      install_ruby_200: lambda {
        dfi :install_ruby, 'http://cache.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p481.tar.gz'
      },
      install_haproxy_153: lambda {
        dfi :install_haproxy, 'http://www.haproxy.org/download/1.5/src/haproxy-1.5.3.tar.gz'
      }
    }.merge(fetch(:dockerfile_helpers)))

    set(:services, {
      haproxy: "haproxy -f /root/conf/haproxy.conf",

      haproxy_config_updater: "/root/bin/pyconfd -t /root/conf/haproxy.conf.tmpl -s haproxy -k USR1 -a $APP_KEY -e #{fetch(:etcd_client_url)}",

      mongodb: "/usr/bin/mongod --bind_ip 0.0.0.0 --logpath /var/log/mongodb.log",

      nginx: "nginx",

      unicorn: "cd /app && bundle exec unicorn -c /root/conf/unicorn.rb",

      pyrep: "/root/bin/pyrep -t #{fetch(:boxchief_app_token)}"

    }.merge(fetch(:services)))

    fetch(:context_extensions)[:starter] = {path: Cloudpad::Starter.gem_context_path}
  end


  namespace :install do

    task :manifests do
      files_path = Cloudpad::Starter.files_path
      sh "cp -auv #{gem_manifests_path} #{root_path}"
    end

  end

end

after 'docker:load', 'starter:load'
