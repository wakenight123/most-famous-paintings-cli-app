class Painter
  attr_accessor :titles, :name, :painter_nationality, :painting

  @@all = []

  def initialize(name)
    @name = name
    @painting
    @painter_nationality = painter_nationality
    @titles = []
  end

  def self.all
    @@all.uniq
  end

  def self.list_all_painters
    scraper.scrape_paintings.each do |card|
      url = card.css("a.col-item").attribute("href").text
      painters = url.css("ul.lined.features > li:nth-child(1) > span > a").text
      @@all << painters
    end
    self.all
  end

  def add_titles(title)
    @titles << title
  end

end
