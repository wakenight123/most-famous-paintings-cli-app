class Scraper

  def scrape_site
    Nokogiri::HTML(open("http://www.brushwiz.com/most-famous-paintings/"))
  end

  # collects total data on all paintings
  def scrape_painting
    self.scrape_site.css("div.col.col-25")
  end

  # enter all painting attributes into painting.all
  def make_painting
    scraper.scrape_painting.each do |card|
      painting.new_from_scraped_site(card)
    end
  end

end
