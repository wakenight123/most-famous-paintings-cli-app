class MostFamousPaintings::Painting
  attr_accessor :title, :ranking, :url, :painter, :painter_medium_size, :description

  @@all = []

  def initialize(title, ranking, url)
    @title = title
    @ranking = ranking
    @url = url
    @@all << self
  end

  def self.new_painting(card, index)
    self.new(
      card.css("h5").text,
      index.to_i + 1,
      "http://en.most-famous-paintings.com/MostFamousPaintings.nsf/#{card.css("a").attribute("href")}")
  end

  def self.all
    @@all
  end

  def self.find(position)
    self.all[position - 1]
  end

  def painter_medium_size
    @painter_medium_size ||= doc.xpath("/html/body/form/div[4]/center/h2").text
  end

  def description
    @description ||= doc.xpath("/html/body/form/div[4]/center/p").text
  end

  def doc
    @doc ||= Nokogiri::HTML(open(self.url))
  end

end
