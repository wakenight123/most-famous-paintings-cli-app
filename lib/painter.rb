require 'nokogiri'
require 'open-uri'
require_relative './scraper.rb'

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

  # enter all painting attributes into painting.all
  def make_paintings
    scraper.scrape_paintings.each_with_index do |card, index|
      self.new(card.css("a > span.col-item-title").text,
      index + 1,
      card.css("a.col-item").attribute("href").text,
      scraper.scrape_painting_profile(url).css("ul.lined.features > li:nth-child(1) > span > a").text,
      scraper.scrape_painting_profile(url).css("ul.lined.features > li:nth-child(3) > span > a").text,
      scraper.scrape_painting_profile(url).css("ul.lined.features > li:nth-child(7) > span > a").text,
      scraper.scrape_painting_profile(url).css("ul.lined.features > li:nth-child(5) > span > a").text,
      scraper.scrape_painting_profile(url).css("ul.lined.features > li:nth-child(4) > span > a").text)
    end
  end

  # lists all painting titles
  def self.list_all_painting_titles
    scraper.scrape_paintings.each do |card|
      title = card("a > span.col-item-title").text
      title_array = []
      title_array << title
    end
    title_array
  end

end

