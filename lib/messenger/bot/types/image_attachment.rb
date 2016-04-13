module Messenger
  module Bot
    module Types
      class ImageAttachment < Base
        attribute :type, String, :default => "image"
        attribute :payload, Image
      end
    end
  end
end
