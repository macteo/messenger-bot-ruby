module Messenger
  module Bot
    module Types
      class Adjustment < Base
        attribute :name, String
        attribute :amount, Float
      end
    end
  end
end
