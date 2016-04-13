module Messenger
  module Bot
    module Types
      class Callback < Base
        attribute :object, String
        attribute :entry, Array[Entry]
      end
    end
  end
end
