require 'nokogiri'
require 'open-uri'
require 'pry'

class Painting
  attr_accessor :title, :url, :painter, :painter_nationality, :location, :style, :time_period

  @@all = []

  def initialize(title, url, painter, painter_nationality, location, style, time_period)
    @title = title
    @url = url
    @painter = painter
    @painter_nationality = painter_nationality
    @location = location
    @style = style
    @time_period = time_period
    @@all << self
  end

  def self.all
    @@all
  end

  # identify attributes of each newly scraped painting
  def self.new_from_scraped_site(card)
    url = card.css("a.col-item").attribute("href").text
    self.new(card.css("a > span.col-item-title").text,
    url,
    url.css("ul.lined.features > li:nth-child(1) > span > a").text,
    url.css("ul.lined.features > li:nth-child(3) > span > a").text,
    url.css("ul.lined.features > li:nth-child(7) > span > a").text,
    url.css("ul.lined.features > li:nth-child(5) > span > a").text,
    url.css("ul.lined.features > li:nth-child(4) > span > a").text)
  end

  # lists all painting titles
  def list_all_paintings
    scraper.scrape_painting.each do |card|
      title = card("a > span.col-item-title").text
      puts title
    end
  end

end
