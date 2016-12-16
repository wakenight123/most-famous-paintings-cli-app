class MostFamousPaintings::Scraper

  def scrape_site
    Nokogiri::HTML(open("http://en.most-famous-paintings.com/MostFamousPaintings.nsf/ListOfTop100MostPopularPainting?OpenForm"))
  end

  def scrape_paintings
    self.scrape_site.css("body > form > div.MFP-Home-Main-Content-Block > div")
  end

  def make_paintings
    scrape_paintings.each_with_index do |card, index|
      MostFamousPaintings::Painting.new_painting(card, index)
    end
  end

end
