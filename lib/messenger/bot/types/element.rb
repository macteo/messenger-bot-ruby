module Messenger
  module Bot
    module Types
      class Element < Base
        attribute :mids, Array[String]
        attribute :watermark, Integer
        attribute :seq, Integer
      end
    end
  end
end
