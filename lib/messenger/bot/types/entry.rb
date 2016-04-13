module Messenger
  module Bot
    module Types
      class Entry < Base
        attribute :id, Integer
        attribute :time, Integer
        attribute :messaging, Array[Messaging]
      end
    end
  end
end
