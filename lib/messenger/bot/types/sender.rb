module Messenger
  module Bot
    module Types
      class Sender < Base
        attribute :id, Integer
        attribute :phone_number, String

        # alias_method :to_s, :text
      end
    end
  end
end
