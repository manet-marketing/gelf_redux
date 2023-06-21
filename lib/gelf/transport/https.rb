module GELF
  module Transport
    class HTTPS
      attr_reader :uri

      def initialize(host, port: 443, path: nil)
        path = "/#{path.to_s.delete_prefix('/')}" if path.present?
        @uri = URI::HTTPS.build host: host, port: port, path: path
      end

      def transfer(message)
        Typhoeus::Request.new(uri, method: :post,
                                   headers: default_headers,
                                   body: message.to_json).run
      end

      def default_headers
        {
          Accept: 'application/json',
          'User-Agent' => Rails.application.class.name.deconstantize,
          'Content-Type' => 'application/json'
        }
      end
    end
  end
end
