module Messenger
  module Bot
    module Types
      class Messaging < Base
        attribute :sender, Sender
        attribute :recipient, Recipient
        attribute :timestamp, Integer
        attribute :message, Message
        attribute :delivery, Delivery
        attribute :postback, Postback
      end
    end
  end
end
