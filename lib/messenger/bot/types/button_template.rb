module Messenger
  module Bot
    module Types
      class ButtonTemplate < Base
        attribute :template_type, String # value must be button
        attribute :text, String
        attribute :buttons, Array[Button]
        alias_method :to_s, :text
      end
    end
  end
end
