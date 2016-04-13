module Messenger
  module Bot
    module Types
      class Image < Base
        attribute :url, String
        alias_method :to_s, :url
      end
    end
  end
end

# Only jpeg and png
