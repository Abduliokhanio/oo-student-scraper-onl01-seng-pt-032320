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
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    students_twitter = []
    students_linkedin = []
    students_github = []
    students_youtube = []
    students_blog = []

    doc.xpath('//div[@class="social-icon-container"]/a').map do |link|
      if link['href'].include?("twitter")
        students_twitter << link['href']
      end
    end

    doc.xpath('//div[@class="social-icon-container"]/a').map do |link|
      if link['href'].include?("linkedin")
        students_linkedin << link['href']
      end
    end

    doc.xpath('//div[@class="social-icon-container"]/a').map do |link|
      if link['href'].include?("github")
        students_github << link['href']
      end
    end

    doc.xpath('//div[@class="social-icon-container"]/a').map do |link|
      if !(link['href'].include?("github")) &&
         !(link['href'].include?("linkedin")) &&
         !(link['href'].include?("twitter"))
         students_blog = link['href']
      end
    end

    students_quote = doc.css(".profile-quote").text
    students_bio = doc.css(".description-holder p").text

    students_twitter
    students_linkedin
    students_github
    students_youtube
      if students_youtube = ""
        students_youtube = nil
      end
    students_blog

    # This needs to be an iteration where it starts with <<output = {}>>
    out_put = {:twitter=>students_twitter[0],
               :linkedin=>students_linkedin[0],
               :github=>students_github[0],
               :profile_quote=>students_quote,
               :blog=>students_blog,
               :bio=> students_bio}
    out_put.delete_if {|key, value| value == [] || value == nil}

    out_put
  end

end
