require "nokogiri"
require 'open-uri'

module Scraper
  class HtmlParser

    # nokogiri parser
    def self.parse(url)
      doc = Nokogiri::HTML(open(url))
    end

    
  end
end
