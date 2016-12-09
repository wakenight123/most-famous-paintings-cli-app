require 'nokogiri'
require 'open-uri'
require 'pry'

class Painting
  attr_accessor :title, :ranking, :url, :painter, :painter_nationality, :location, :style, :time_period

  @@all = []

  def initialize(title, ranking, url, painter, painter_nationality, location, style, time_period)
    @title = title
    @ranking = ranking
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
    @url = card.css("a.col-item").attribute("href").text

    self.new(card.css("a > span.col-item-title").text,
    index + 1,
    card.css("a.col-item").attribute("href").text
    scraper.scrape_painting_profile(url).css("ul.lined.features > li:nth-child(1) > span > a").text,
    scraper.scrape_painting_profile(url).css("ul.lined.features > li:nth-child(3) > span > a").text,
    scraper.scrape_painting_profile(url).css("ul.lined.features > li:nth-child(7) > span > a").text,
    scraper.scrape_painting_profile(url).css("ul.lined.features > li:nth-child(5) > span > a").text,
    scraper.scrape_painting_profile(url).css("ul.lined.features > li:nth-child(4) > span > a").text)
  end

  # lists all painting titles
  def list_all_painting_titles
    scraper.scrape_paintings.each do |card|
      title = card("a > span.col-item-title").text
      title_array = []
      title_array << title
    end
    title_array
  end

end
