class MostFamousPaintings::Scraper

  # scrapes total data on all paintings into an array of hashes
  def self.paintings_hash
    paintings = []
    doc = Nokogiri::HTML(open("http://www.brushwiz.com/most-famous-paintings/"))
    doc.css("body > div.page > div.content.visible.page-design > div.page-section.section-extended.loadmored > div.row.items-grid.grid-categories.page-section").each_with_index do |card, index|
      painting = {}
      painting[:title] = card.css("a > span.col-item-title").text
      painting[:ranking] = index + 1
      painting[:url] = card.css("a.col-item").attribute("href").text
      paintings << painting
    end
    paintings
  end

  # scrapes profile info of specific painting
  def self.painting_info(url)
    profile = Nokogiri::HTML(open(url))
    info = {
    painter: profile.css("ul.lined.features > li:nth-child(1) > span > a").text,
    painter_nationality: profile.css("ul.lined.features > li:nth-child(3) > span > a").text,
    location: profile.css("ul.lined.features > li:nth-child(7) > span > a").text,
    style: profile.css("ul.lined.features > li:nth-child(5) > span > a").text,
    time_period: profile.css("ul.lined.features > li:nth-child(4) > span > a").text}
    info
  end

end
