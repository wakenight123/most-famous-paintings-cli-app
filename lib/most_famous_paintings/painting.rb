class MostFamousPaintings::Painting
  attr_accessor :title, :ranking, :url, :painter, :painter_nationality, :location, :style, :time_period

  @@all = []

  def initialize(title, ranking, url)
    @title = title
    @ranking = ranking
    @url = url
    @@all << self
  end

  def self.new_painting(card, index)
    self.new(
      card.css("span.col-item-title").text,
      index.to_i + 1,
      "http://www.brushwiz.com/#{card.css("a.col-item").attribute("href").text}")
  end

  def self.all
    @@all
  end

  def self.find(position)
    self.all[position - 1]
  end

  def painter
    @painter ||= doc.xpath("/html/body/div[10]/div[2]/div[8]/div[2]/div[1]/div[2]/ul/li[1]/span/a").text
  end

  def painter_nationality
    @painter_nationality ||= doc.xpath("/html/body/div[10]/div[2]/div[8]/div[2]/div[1]/div[2]/ul/li[3]/span/a").text
  end

  def location
    @location ||= doc.xpath("/html/body/div[10]/div[2]/div[8]/div[2]/div[1]/div[2]/ul/li[7]/span/a").text
  end

  def style
    @style ||= doc.xpath("/html/body/div[10]/div[2]/div[8]/div[2]/div[1]/div[2]/ul/li[5]/span/a").text
  end

  def time_period
    @time_period ||= doc.xpath("/html/body/div[10]/div[2]/div[8]/div[2]/div[1]/div[2]/ul/li[4]/span/a").text
  end

  def doc
    @doc ||= Nokogiri::HTML(open(self.url))
  end

end
