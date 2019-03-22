module Coindcx
  module Rest
    class Base < Coindcx::Rest::Config

      def http_request method, method_data, payload
        headers, params, endpoint = request_params(method, method_data, payload)
        puts "#{headers} --- #{params} -- #{endpoint}"
        uri = URI.parse(endpoint)
        https = Net::HTTP.new(uri.host, uri.port)
        # https.use_ssl = true
        if method == "POST"
          request = Net::HTTP::Post.new(uri.path, headers)
          request.body = params.to_json
        elsif method == "PUT"
          request = Net::HTTP::Put.new(uri.path, headers)
          request.body = params.to_json
        else method == "GET"
          request = Net::HTTP::Get.new(uri.path, headers)
        end
        response = https.request(request)
        JSON.parse(response.body)
      end

      def request_params method, method_data, payload
        if method_data["authentication"]
          signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), @secret, payload.to_json)
          headers = {
            'Content-Type' => 'application/json',
            'X-AUTH-APIKEY' => @key, 
            'X-AUTH-SIGNATURE' => signature
          }
          [headers, payload, endpoint(method, method_data, payload)]
        else
          headers = {
            'Content-Type' => 'application/json',
          }
          [headers, payload, endpoint(method, method_data, payload)]
        end
      end

      def endpoint method, method_data, payload
        if method_data["parameters"]["type"] == "url"
          endpoint = method_data["endpoint"]
          method_data["parameters"]["replace"].each do |key, value|
            endpoint.gsub!(key, payload[value])
          end
        elsif method_data["parameters"]["type"] == "query"
          query_string = URI.encode(payload.map{|k,v| "#{k}=#{v}"}.join("&"))
          endpoint = "#{method_data["endpoint"]}?#{query_string}"
        elsif method_data["parameters"]["type"] == "body"
          endpoint = method_data["endpoint"]
        end
        "#{BASE_URL}#{endpoint}"
      end

    end
  end
end