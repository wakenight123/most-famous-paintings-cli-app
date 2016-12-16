class MostFamousPaintings::Cli

  def call
    MostFamousPaintings::Scraper.new.make_paintings
    puts "Welcome to the Directory of the World's Most Famous Paintings!"
    start
  end

  def start
    puts ""
    puts "Which paintings would you like to see? Please enter the paintings' ranking interval. For example, you may enter 1-20."
    input = gets.strip.to_s

    if input.split("-").each {|num| num.to_i.between?(1, 100)}
      print_paintings(input)
      select_painting?
    else
      puts "Invalid entry. Please try again."
      puts ""
      start
    end
  end

  def play_again
    input = gets.strip.downcase
    if input == "yes"
      start
    elsif input == "no"
      puts "Thank you for playing. Please come back to play again soon!"
    else
      puts "Invalid entry. Please enter yes or no."
      play_again
    end
  end

  def print_paintings(input)
    from = input.to_s.split("-")[0].to_i
    to = input.to_s.split("-")[1].to_i
    range = to-from+1
    puts ""
    puts "----- Paintings ranked # #{from} - #{to} -----"
    puts ""
    MostFamousPaintings::Painting.all[from-1, range].each {|p|
      puts "#{p.ranking}. #{p.title}"}
  end

  def print_painting(painting)
    puts ""
    puts "----- #{painting.title} - ##{painting.ranking} -----"
    puts ""
    puts "Painter:    #{painting.painter} (#{painting.painter_nationality})"
    puts "Location:   #{painting.location}"
    puts "Style:      #{painting.style}"
    puts "Era:        #{painting.time_period}"
  end

  def select_painting?
    puts ""
    puts "Would you like more information on a specific painting? Please enter the painting's ranking number or type 'return' to browse more painting lists."
    input = gets.strip
    if input.to_i.between?(1, 100)
      painting = MostFamousPaintings::Painting.find(input.to_i)
      print_painting(painting)
      puts ""
      puts "Would you like to see more paintings?"
      play_again
    elsif input.to_s == "return"
      start
    else
      "Invalid entry."
      select_painting?
    end
  end

end
