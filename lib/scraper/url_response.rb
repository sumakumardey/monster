require 'net/http'
require 'uri'

module Scraper
  class UrlResponse
    def self.html_response(url = "http://indiarailinfo.com/train/seats/reservation-availability-amritsar-new-delhi-intercity-express-12460-asr-to-ndls/1189/344/664")
      # url = "http://indiarailinfo.com/train/seats/reservation-availability-amritsar-new-delhi-intercity-express-12460-asr-to-ndls/1189/344/664"
      # require "net/http"
      # require "uri"

      uri = URI.parse(url)

      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)

      response = http.request(request)
      response.body
    end
  end
end
