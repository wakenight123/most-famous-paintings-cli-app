require 'nokogiri'
require 'open-uri'
require 'pry'

class Painting
  attr_accessor :painter, :location, :style, :century

  @@all = []

  def initialize
    @painter = painter
    @location = location
    @style = style
    @century = century
    @@all << self
  end

  def self.newly_scraped(piece)
    self.new(piece.css(".col-item-title").text)
  end

  def self.all
    @@all
  end

  def original_painter
    @painter ||= doc.xpath("//div[@class='mobile-480-hide']/p/a").text
  end

  def painting_location
    @location ||= doc.xpath("//div[@class='page-section']/ul[1]/li[7]/a").text
  end

  def painting_style
    @style ||= doc.xpath("//div[@class='page-section']/ul[1]/li[5]/a").text
  end

  def time_period
    @century ||= doc.xpath("//div[@class='page-section']/ul[1]/li[4]/a").text
  end

  def doc
    @doc ||= Nokogiri::HTML(open(self.url))
  end

end
