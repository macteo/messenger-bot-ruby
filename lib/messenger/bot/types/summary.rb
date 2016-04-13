module Messenger
  module Bot
    module Types
      class Summary < Base
        attribute :subtotal, Float
        attribute :shipping_cost, Float
        attribute :total_tax, Float
        attribute :total_cost, Float
      end
    end
  end
end
