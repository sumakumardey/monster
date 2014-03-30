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
        pnr_table = PnrTable.create(hash_obj)
        PassengerStatus.create(:pnr_table_id => pnr_table.id,
                               :pnr_number => pnr,
                               :booking_status => data[9].text,
                               :current_status => data[10].text)
      end

    end

    def self.indian_rail_info(url)
      doc = Nokogiri::HTML(Scraper::UrlResponse.html_response_for_url(url))
      next_link = doc.xpath('//*[@id="MainBody"]/div[2]/table/tr[2]/td[1]/div/div[3]/a')
      link_data = ""
      create_pnr_table(doc)
      if !next_link.blank?
        link_data = next_link.attribute("href").value
      else
        next_link = doc.xpath('//*[@id="MainBody"]/div[2]/table/tr[2]/td[1]/div/div[1]/a[1]')
        unless next_link.blank?
          link_data = next_link.attribute("href").value
        end
      end
      unless link_data.blank?
        self.indian_rail_info(link_data)
      end
    end

    def self.create_pnr_table(doc)
      xpath = '//*[starts-with(@id,"PU-")]'
      new_doc = doc.xpath(xpath)

      new_doc.each do |child_doc|
        attribute_id = child_doc.attributes["id"].value.split("-")[2]
        next if !attribute_id.nil? && attribute_id.to_i >= 1
        p  boarding_date(child_doc)
        # p stating_point_ending_point(child_doc).split("to")
        train_number, train_name = train_number_and_name(child_doc).split("/")
        starting_point,ending_point= stating_point_ending_point(child_doc).split("to")

        hash_obj_pnr_table = {
          # :pnr_number => ,
          :train_number => train_number,
          :train_name => train_name,
          :boarding_date => boarding_date(child_doc),
          :starting_point => starting_point.split("/")[0],
          :ending_point => ending_point.split("/")[0],
          #     :reserved_upto => data[5].text,
          #     :boarding_point => data[6].text,
          :seat_class => seat_class(child_doc)
        }
        pnr_table = PnrTable.create(hash_obj_pnr_table)

        hash_table_passenger_status = {
          :booking_status => booking_status(child_doc),
          :current_status => current_status(child_doc),
          :pnr_table_id => pnr_table.id
        }
        PassengerStatus.create(hash_table_passenger_status)
      end
    end

    def self.train_number_and_name(child_doc)
      xpath_relative = "/div/a[1]"
      xpath_absolute = child_id_xpath(child_doc,xpath_relative)
      get_xpath_value(child_doc,xpath_absolute)
    end

    def self.seat_class(child_doc)
      xpath_relative = "/div/span/text()[1]"
      xpath_absolute = child_id_xpath(child_doc,xpath_relative)
      get_xpath_value(child_doc,xpath_absolute)
    end

    def self.stating_point_ending_point(child_doc)
      xpath_relative="/div/div[5]"
      xpath_absolute = child_id_xpath(child_doc,xpath_relative)
      get_xpath_value(child_doc,xpath_absolute)
    end

    def self.child_id_xpath(child_doc,path)
      id = child_doc.attributes["id"].value
      "//*[starts-with(@id,'#{id}')]#{path}"
    end

    def self.current_status(child_doc)
      xpath_relative="/div/div[6]/span[1]"
      xpath_absolute = child_id_xpath(child_doc,xpath_relative)
      get_xpath_value(child_doc,xpath_absolute)
    end

    def self.booking_status(child_doc)
      xpath_relative= "/div/div[6]/text()[2]"
      xpath_absolute = child_id_xpath(child_doc,xpath_relative)
      get_xpath_value(child_doc,xpath_absolute).split(":")[1]
    end


    def self.boarding_date(child_doc)
      xpath_relative = "/div/div[3]"
      xpath_absolute = child_id_xpath(child_doc,xpath_relative)
      # date = child_doc.xpath(xpath).text
      date = get_xpath_value(child_doc,xpath_absolute)
      # p boarding_date
      Time.strptime(date, 'Journey: %a %b %d, %Y @ %H:%M')
    end

    def self.get_xpath_value(child_doc,xpath)
      child_doc.xpath(xpath).text
    end
  end
end
