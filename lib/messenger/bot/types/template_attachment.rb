module Messenger
  module Bot
    module Types
      class TemplateAttachment < Base
        attribute :type, String, :default => "template"
        attribute :payload, Hash
      end
    end
  end
end
