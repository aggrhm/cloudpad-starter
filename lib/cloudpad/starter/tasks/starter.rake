require 'fileutils'

namespace :starter do

  task :load do
    fetch(:dockerfile_helpers).merge!({
      install_ruby_200: lambda {
        dfi :run, 'installers/install_ruby.sh', 'http://cache.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p481.tar.gz'
      },
      install_haproxy_153: lambda {
        dfi :run, 'installers/install_haproxy.sh', 'http://www.haproxy.org/download/1.5/src/haproxy-1.5.3.tar.gz'
      }
    })
  end


  namespace :install do
    desc "Install files to project"
    task :all do

      files_path = Cloudpad::Starter.files_path
      puts "Installing starter files from #{files_path}.".yellow
      # TODO: get list of all files in dir and copy if changed
      sh "cp -auv #{files_path}/* #{root_path}"
    end

    task :manifests do
      files_path = Cloudpad::Starter.files_path
      sh "cp -auv #{files_path}/manifests #{root_path}"
    end
    task :context do
      files_path = Cloudpad::Starter.files_path
      sh "cp -auv #{files_path}/context #{root_path}"
    end
    task :bin do
      files_path = Cloudpad::Starter.files_path
      sh "cp -auv #{files_path}/context/bin #{root_path}/context"
    end
    task :conf do
      files_path = Cloudpad::Starter.files_path
      sh "cp -auv #{files_path}/context/conf #{root_path}/context"
    end
    task :installers do
      files_path = Cloudpad::Starter.files_path
      sh "cp -auv #{files_path}/context/installers #{root_path}/context"
    end
    task :keys do
      files_path = Cloudpad::Starter.files_path
      sh "cp -auv #{files_path}/context/keys #{root_path}/context"
    end
    task :services do
      files_path = Cloudpad::Starter.files_path
      sh "cp -auv #{files_path}/context/services #{root_path}/context"
    end

  end

end

after 'docker:load', 'starter:load'
