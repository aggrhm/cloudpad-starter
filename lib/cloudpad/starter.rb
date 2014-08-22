require "cloudpad/starter/version"

module Cloudpad
  module Starter
    # Your code goes here...
    def self.files_path
      File.expand_path("../../../files", __FILE__)
    end
  end
end

load File.expand_path("../starter/tasks/starter.rake", __FILE__)
