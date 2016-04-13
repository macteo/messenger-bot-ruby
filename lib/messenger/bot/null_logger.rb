module Messenger
  module Bot
    class NullLogger < Logger
      def initialize(*)
      end

      def add(*)
      end
    end
  end
end
