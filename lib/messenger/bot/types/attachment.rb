module Messenger
  module Bot
    module Types
      class Attachment < Base
        attribute :type, String
        attribute :payload, Payload
      end
    end
  end
end
