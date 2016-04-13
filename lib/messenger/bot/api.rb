module Messenger
  module Bot
    class Api
      include HTTMultiParty
      ENDPOINTS = %w(
              messages
            ).freeze
      POOL_SIZE = ENV.fetch('MESSENGER_BOT_POOL_SIZE', 1).to_i.freeze

      attr_reader :token

      base_uri 'https://graph.facebook.com/v2.6/'
      persistent_connection_adapter pool_size: POOL_SIZE,
                                    keep_alive: 30,
                                    force_retry: true

      def initialize(token)
        @token = token
      end

      def method_missing(method_name, *args, &block)
        endpoint = method_name.to_s
        endpoint = camelize(endpoint) if endpoint.include?('_')

        ENDPOINTS.include?(endpoint) ? call(endpoint, *args) : super
      end

      def respond_to_missing?(*args)
        method_name = args[0].to_s
        method_name = camelize(method_name) if method_name.include?('_')

        ENDPOINTS.include?(method_name) || super
      end

      def user_profile(user_id)
        response = self.class.get("#{user_id}?fields=first_name,last_name,profile_pic&access_token=#{token}")
        if response.code == 200
          response.to_hash
        else
          fail Exceptions::ResponseError.new(response),
               'Messenger API has returned the error.'
        end
      end

      def call(endpoint, raw_params = {})
        params = build_params(raw_params)
        response = self.class.post("/me/#{endpoint}?access_token=#{token}", query: params)
        if response.code == 200
          response.to_hash
        else
          fail Exceptions::ResponseError.new(response),
               'Messenger API has returned the error.'
        end
      end

      private

      def build_params(h)
        h.each_with_object({}) do |(key, value), params|
          params[key] = sanitize_value(value)
        end
      end

      def sanitize_value(value)
        jsonify(jsonify_with_file_preservation(value))
      end

      def jsonify_with_file_preservation(value)
        if !value.is_a?(File)
          return value.to_h.to_json
        end
        return value
      end

      def jsonify(value)
        return value unless value.is_a?(Array)
        value.map { |i| i.to_h.select { |_, v| v } }.to_json
      end

      def camelize(method_name)
        words = method_name.split('_')
        words.drop(1).map(&:capitalize!)
        words.join
      end
    end
  end
end
