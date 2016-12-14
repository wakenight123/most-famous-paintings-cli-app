class MostFamousPaintings::Painting
  attr_accessor :title, :ranking, :url, :painter, :painter_nationality, :location, :style, :time_period

  @@all = []

  def initialize(painting)
    @title = painting[:title]
    @ranking = painting[:ranking]
    @url = painting[:url]
    @@all << self
  end

  def self.all
    @@all
  end

  def self.create_paintings(paintings)
    MostFamousPaintings::Scraper.paintings_hash.each do |painting_hash|
      painting = self.new(painting_hash)
    end
  end

  def add_painting_info(info)
    @painter = info[:painter]
    @painter_nationality = info[:painter_nationality]
    @location = info[:location]
    @style = info[:style]
    @time_period = info[:time_period]
  end

end
