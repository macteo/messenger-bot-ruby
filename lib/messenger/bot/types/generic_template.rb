module Messenger
  module Bot
    module Types
      class GenericTemplate < Base
        attribute :template_type, String # generic
        attribute :elements, Array[Element]
      end
    end
  end
end

=begin

# Generic Template Guidelines

## Limits

- Title: 45 characters
- Subtitle: 80 characters
- Call-to-action title: 20 characters
- Call-to-action items: 3 buttons
- Bubbles per message (horizontal scroll): 10 elements

## Image Dimensions

Image ratio is 1.91:1

=end
