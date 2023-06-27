module GELF
  module Transport
    class HTTP
      def initialize(host, port: 80, path: '', headers: nil)
        @uri = URI::HTTP.build host: host, port: port
        @headers = headers
        @path = path
      end

      def start_connection
        @uri.path = "/#{@path.to_s.delete_prefix('/')}"
        @http = Net::HTTP.new(@uri.host, @uri.port)
        @http.use_ssl = true if @uri.instance_of? URI::HTTPS
        given_headers = @headers || {}
        @headers = default_headers.merge(given_headers)
      end

      def transfer(message)
        start_connection
        request = Net::HTTP::Post.new(@uri.request_uri)
        request.body = json_dump(message)
        @headers.each do |key, value|
          # pass header only if value present -> allows clearing default headers
          request[key] = value if value
        end
        @http.request(request)
      end

      def default_headers
        {
          'Accept' => 'application/json',
          'Content-Type' => 'application/json'
        }
      end
    end
  end
end