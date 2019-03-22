require 'net/http'
require 'uri'
require 'json'
require 'openssl'
require_relative "config"
require_relative "base"


module Coindcx
  module Rest
    class Client < Coindcx::Rest::Base

      def initialize key=nil, secret=nil
        @key, @secret = key, secret
      end

    end
  end
end