require "cloudpad/starter/version"

module Cloudpad
  module Starter
    # Your code goes here...
    def self.gem_manifests_path
      File.expand_path("../../../manifests", __FILE__)
    end
    def self.gem_context_path
      File.expand_path("../../../context", __FILE__)
    end
  end
end

load File.expand_path("../starter/tasks/starter.rake", __FILE__)
