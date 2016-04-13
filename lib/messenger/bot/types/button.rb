module Messenger
  module Bot
    module Types
      class Button < Base
        attribute :type, String # web_url or postback
        attribute :title, String
        attribute :url, String # Required for web_url buttons
        attribute :payload, String # Required for postback buttons
      end
    end
  end
end
