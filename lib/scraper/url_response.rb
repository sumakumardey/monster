require 'net/http'
require 'uri'

module Scraper
  class UrlResponse
    def self.html_response(pnr)
      url = "http://www.indianrail.gov.in/cgi_bin/inet_pnstat_cgi_24335.cgi"
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.request_uri)
      request.add_field "Pragma","no-cache"
      request.add_field "Origin","http://www.indianrail.gov.in"
      request.add_field "Content-Type","application/x-www-form-urlencoded"
      request.add_field "Referer", "http://www.indianrail.gov.in/pnr_Enq.html"
      params = { :lccp_pnrno1 => pnr, :lccp_cap_val => "77748", :lccp_capinp_val => "77748" }
      request.set_form_data(params)
      response = http.request(request)
      response.body
    end

    def self.html_response_for_url(url)
      # url = "http://indiarailinfo.com/train/seats/reservation-availability-amritsar-new-delhi-intercity-express-12460-asr-to-ndls/1189/344/664"
      # require "net/http"
      # require "uri"
      domain = "http://indiarailinfo.com/"
      url = domain + url
      uri = URI.parse(url)

      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)

      response = http.request(request)
      response.body
    end
  end
end
