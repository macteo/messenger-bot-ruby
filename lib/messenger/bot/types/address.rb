module Messenger
  module Bot
    module Types
      class Address < Base
        attribute :street_1, String
        attribute :street_2, String
        attribute :city, String
        attribute :postal_code, String
        attribute :state, String
        attribute :country, String
      end
    end
  end
end
