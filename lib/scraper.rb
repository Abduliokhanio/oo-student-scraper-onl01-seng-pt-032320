require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    binding.pry
    doc.css(".student-name")[0].text       #name
    doc.css(".student-location")[0].text   #location
    doc.css(".student-card")[0].elements[0].attribute("href").value  #profile url
  end

  def self.scrape_profile_page(profile_url)

  end

end
