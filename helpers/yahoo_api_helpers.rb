# encoding: UTF-8

require 'sinatra/base'
require 'net/http'
require 'csv'

module Sinatra
  module ResponseWithRedirect

    def get_response_with_redirect(*symbols)
      begin
        uri = generate_uri(symbols)
        r = Net::HTTP.get_response(uri)
        if r.code == "301"
          r = Net::HTTP.get_response(URI.parse(r.header['location']))
          handle_response(r)
        end
      rescue Exception => e
        return false
      end
    end

    def generate_uri(*symbols)
      uri = URI("http://finance.yahoo.com/d/quotes.csv?&f=sl1d1t1&s=" + symbols.join("=X,") { |s| s } + "=X")
    end

    def handle_response(r)
      conversions = Array.new
      CSV.parse(r.body) do |row| 
        conversions << Conversion.new(row[0],row[1],row[2],row[3])
      end
      return conversions
    end

  end
end
