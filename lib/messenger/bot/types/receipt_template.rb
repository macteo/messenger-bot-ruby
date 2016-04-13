module Messenger
  module Bot
    module Types
      class ReceiptTemplate < Base
        attribute :template_type, String # receipt
        attribute :recipient_name, String
        attribute :order_number, String
        attribute :currency, String
        attribute :payment_method, String
        attribute :timestamp, String
        attribute :order_url, String
        attribute :elements, Array[ReceiptElement]
        attribute :address, Address
        attribute :summary, Summary
        attribute :adjustments, Array[Adjustment]
      end
    end
  end
end
