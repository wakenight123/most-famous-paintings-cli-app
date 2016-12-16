class MostFamousPaintings::Scraper

  def scrape_site
    Nokogiri::HTML(open("http://www.brushwiz.com/most-famous-paintings/"))
  end

  def scrape_paintings
    self.scrape_site.css("body > div.page > div.content.visible.page-design > div.page-section.section-extended.loadmored > div > div")
  end

  def make_paintings
    scrape_paintings.each_with_index do |card, index|
      MostFamousPaintings::Painting.new_painting(card, index)
    end
  end

end
