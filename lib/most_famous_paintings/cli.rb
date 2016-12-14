class MostFamousPaintings::Cli

  def call
    make_paintings
    add_info_to_paintings
    start
  end

  def make_paintings
    paintings = MostFamousPaintings::Scraper.paintings_hash
    MostFamousPaintings::Painting.create_paintings(paintings)
  end

  def add_info_to_paintings
    MostFamousPaintings::Painting.all.each do |painting|
      info = MostFamousPaintings::Scraper.painting_info(painting.url)
      painting.add_painting_info(info)
    end
  end

  def start
    puts ""
    puts "Welcome to the Directory of the World's Most Famous Paintings!"
    search
  end

  def search
    puts ""
    puts "Would you like to search for a painting by painter, title or rank?"
    input = gets.strip.downcase
    if input == "painter" || input == "by painter"
      puts ""
      puts "Please enter the name of the painter."
      search_by_painter
    elsif input == "title" || input == "by title"
      puts ""
      puts "Please enter the title of the painting."
      search_by_title
    elsif input == "rank" || input == "by rank"
      search_by_rank
    else
      puts ""
      puts "Invalid form of search. Please try again."
      search
    end
  end

  def search_by_painter
    input = gets.strip.downcase
    if MostFamousPaintings::Painter.all.detect{|painter| painter.downcase == input} != nil
      painter = MostFamousPaintings::Painter.new(painter)
      puts ""
      puts "#{painter}(#{painter.painter_nationality}) has #{painter.titles.count} paintings that are included in The Most Famous Paintings of All-Time:"
      puts ""
      MostFamousPaintings::Painter.titles.each do |painting|
        puts " ##{painting.ranking} - '#{painting.title}', #{painting.time_period} (#{painting.style}) in #{painting.location}"
      end
      puts ""
      puts "Would you like to search again?"
      play_again
    else
      puts "Sorry, this painter's works are not mentioned in this list of The Most Famous Paintings of All-Time. Please enter another painter's name."
      search_by_painter
    end
  end

  def search_by_title
    input = gets.strip.downcase
    if MostFamousPaintings::Painting.all{|painting| painting.downcase == input} != nil
      puts ""
      puts "'#{painting.title}' is ranked ##{painting.ranking} in this list of The Most Famous Paintings of All-Time."
      puts ""
      puts "painter:     #{painting.painter}(#{painter.painter_nationality})"
      puts "time period: #{painting.time_period}"
      puts "style:       #{painting.style}"
      puts "location:    #{painting.location}"
      puts ""
      puts "Would you like to search for another painting?"
      play_again
    else
      puts "Sorry, this painting is not mentioned in this list of The Most Famous Paintings of All-Time. Please enter another the title of another painting."
      search_by_title
    end
  end

  def search_by_rank
    puts "Please choose a ranking interval from 1-100. For example, you can enter 1-25."
    puts ""
    input = gets.strip.to_s
    if input.split("-").each {|num| num.to_i.between?(1, 100) == true}
      from = input.split("-")[0].to_i
      to = input.split("-")[1].to_i
      puts ""
      puts "----- Paintings ranked # #{from} - #{to} -----"

      MostFamousPaintings::Painting.all[from-1 ,to-from+1].each_with_index do |p, index|
        puts "#{index}. '#{p.title}' by #{p.painter}(#{p.painter_nationality}), #{p.time_period}"
        end
      puts ""
      puts "Would you like to search for more paintings?"
      play_again
    else
        puts "Invalid entry. Please try again."
        puts ""
        search_by_rank
    end
  end

  def play_again
    input = gets.strip.downcase
    if input == "yes"
      search
    elsif input == "no"
      puts "Thank you for playing. Please come back to play again soon!"
    else
      puts "Invalid entry. Please enter yes or no."
      play_again
    end
  end

end
