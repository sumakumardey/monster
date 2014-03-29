require "nokogiri"
require 'open-uri'
require 'scraper/url_response'

module Scraper
  class HtmlParser
    # nokogiri parser
    def self.parse(url)
      doc = Nokogiri::HTML(open(url))
    end

    def self.indian_rail(pnr)
      doc = Nokogiri::HTML(Scraper::UrlResponse.html_response(pnr))
      data = doc.xpath('//*[starts-with(@class,"table_border_both")]')
      unless (data.blank?)
      	date = data[2].text.gsub(/\s+/, "").split("-")
      	time = Time.local(date[2],date[1],date[0])
      	return if data[0].text.blank?
        hash_obj = {
          :pnr_number => pnr,
          :train_number => data[0].text.gsub("*",""),
          :train_name => data[1].text,
          :boarding_date => time,
          :starting_point => data[3].text,
          :ending_point => data[4].text,
          :reserved_upto => data[5].text,
          :boarding_point => data[6].text,
          :seat_class => data[7].text
        }
        PnrTable.create(hash_obj)
      end
      
    end

  end
end
