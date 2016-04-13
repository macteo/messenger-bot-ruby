module Messenger
  module Bot
    module Types
      class Message < Base
        attribute :text, String
        attribute :mid, String
        attribute :seq, Integer
        attribute :attachments, Array[Attachment]

        alias_method :to_s, :text
      end
    end
  end
end
