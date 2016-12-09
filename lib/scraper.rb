require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './painting.rb'

class Scraper

  def scrape_site
    Nokogiri::HTML(open("http://www.brushwiz.com/most-famous-paintings/"))
  end

  # collects total data on all paintings
  def scrape_paintings
    self.scrape_site.css("div.col.col-25")
  end

  def scrape_painting_profile(url)
    Nokogiri::HTML(open(url))
  end

  # enter all painting attributes into painting.all
  def make_paintings
    scraper.scrape_paintings.each_with_index do |card|
      painting.new_from_scraped_site(card)
    end
  end

end

