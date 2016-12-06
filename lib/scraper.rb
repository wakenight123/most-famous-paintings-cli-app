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
