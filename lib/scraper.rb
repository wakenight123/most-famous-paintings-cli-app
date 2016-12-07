require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './painting.rb'

class Scraper

  def scrape_site
    Nokogiri::HTML(open("http://www.brushwiz.com/most-famous-paintings/"))
  end

  def scrape_painting
    self.scrape_site.css("div.col.col-25")
  end

  def officialize_painting
    scrape_painting.each do |piece|
      Painting.newly_scraped(piece)
    end
  end

end

