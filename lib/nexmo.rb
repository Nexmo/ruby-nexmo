require 'net/http'
require 'net/https'
require 'json'
require 'uri'

module Nexmo
  class Client
    def initialize(key, secret)
      @key, @secret = key, secret

      @headers = {'Content-Type' => 'application/x-www-form-urlencoded', 'Accept' => 'application/json'}

      @http = Net::HTTP.new('rest.nexmo.com', 443)

      @http.use_ssl = true
    end

    attr_accessor :key, :secret, :http, :headers

    def send_message(data)
      response = @http.post('/sms/json', encode(data), headers)

      object = JSON.parse(response.body)['messages'].first

      status = object['status'].to_i

      if status == 0
        Success.new(object['message-id'])
      else
        Failure.new(Error.new("#{object['error-text']} (status=#{status})"))
      end
    end

    def get_balance
      response = @http.get("/account/get-balance/#{key}/#{secret}", headers)
      object = JSON.parse(response.body)

      return object['value']
    end

    private

    def encode(data)
      URI.encode_www_form data.merge(:username => @key, :password => @secret)
    end
  end

  class Success < Struct.new(:message_id)
    def success?
      true
    end

    def failure?
      false
    end
  end

  class Failure < Struct.new(:error)
    def success?
      false
    end

    def failure?
      true
    end
  end

  class Error < StandardError
  end
end
