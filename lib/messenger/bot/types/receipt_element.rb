module Messenger
  module Bot
    module Types
      class ReceiptElement < Base
        attribute :title, String
        attribute :subtitle, String
        attribute :quantity, Float
        attribute :price, String
        attribute :currency, String
        attribute :image_url, String
      end
    end
  end
end
