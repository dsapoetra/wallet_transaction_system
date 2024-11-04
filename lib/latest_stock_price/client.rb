# lib/latest_stock_price/client.rb
require 'net/http'
require 'json'

module LatestStockPrice
  class Client
    BASE_URL = 'https://latest-stock-price.p.rapidapi.com'

    def initialize
      @headers = {
        'X-RapidAPI-Host' => 'latest-stock-price.p.rapidapi.com',
        'X-RapidAPI-Key' => '7d46353097mshf02b53b21e163d6p184c5ajsnf84c46ffde5d'
      }
    end

    def price_all
      request('/any')
    end

    def equities
      request('/equities')
    end

    private

    def request(endpoint)
      uri = URI("#{BASE_URL}#{endpoint}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri, @headers)
      response = http.request(request)

      raise "Error: #{response.message}" unless response.is_a?(Net::HTTPSuccess)

      JSON.parse(response.body)
    end
  end
end
