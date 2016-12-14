class MostFamousPaintings::Painter
  attr_accessor :name, :paintings

  @@painting_count = 0

  def initialize(name)
    @name = name
    @paintings = []
  end

  def paintings
    @paintings
  end

  def add_painting_by_title(title)
    painting = Painting.new(title)
    @paintings << painting
    painting.painter = self
    @@painting_count += 1
  end

  def add_painting(painting)
    @paintings << painting
    painting.painter = self
    @@painting_count += 1
  end

  def self.painting_count
    @@painting_count
  end

end
