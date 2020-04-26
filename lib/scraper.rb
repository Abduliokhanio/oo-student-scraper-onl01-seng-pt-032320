require 'open-uri'
require 'net/http'
require 'json'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    array1 = []
    epoc = 0

    while epoc < doc.css(".student-name").length
      array1 << {:name => doc.css(".student-name")[epoc].text, :location => doc.css(".student-location")[epoc].text, :profile_url => doc.css(".student-card")[epoc].elements.attribute("href").value}
    #doc.css(".student-name")[0].text                              #name
    #doc.css(".student-location")[0].text                          #location
    #doc.css(".student-card")[0].elements.attribute("href").value  #profile url
      epoc += 1
    end

    array1
  end

  def self.scrape_profile_page(profile_url)
    binding.pry
  end

end
