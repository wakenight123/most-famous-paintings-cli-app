def scrape_site
    Nokogiri::HTML(open("http://en.most-famous-paintings.com/MostFamousPaintings.nsf/ListOfTop100MostPopularPainting?OpenForm"))
  end

  def scrape_paintings
    self.scrape_site.css("body > form > div.MFP-Home-Main-Content-Block > div")
  end

  def make_paintings
    scrape_paintings.each_with_index do |card, index|
      MostFamousPaintings::Painting.new(
        card.css("h5").text,
        index.to_i + 1,
        "http://en.most-famous-paintings.com/MostFamousPaintings.nsf/#{card.css("a").attribute("href")}")
    end
  end

end
