<<<<<<< Updated upstream
require 'nokogiri'
require 'open-uri'

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

end
=======
require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page
    paintings = []
    doc = Nokogiri::HTML(open(https://www.artsy.net/gene/renaissance))
    doc.css(".artist-fillwidth-list-artworks li.artist-fillwidth-row").each do |card|
      painting = {}
      painting[:painter] = card.css(".artwork-item-caption p.artwork-item-artist").text
      painting[:title] = card.css(".artwork-item-caption p.artwork-item-title").text
      painting[:location] = card.css(".artwork-item-caption p.artwork-item-partner").text
      painting[:url] = card.css(".artwork-item-image-container a img").attribute("src").value

      paintings.push(painting)
    end
    paintings
  end

end
>>>>>>> Stashed changes
