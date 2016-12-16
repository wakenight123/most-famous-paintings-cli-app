class MostFamousPaintings::Cli

  def call
    MostFamousPaintings::Scraper.new.make_paintings
    puts ""
    puts "Welcome to the Directory of the World's 100 Most Famous Paintings!"
    start
  end

  def start
    puts ""
    puts "Which paintings would you like to see? Please enter a painting's ranking number or interval. For example, you may enter '1' or '1-20'."
    input = gets.strip.to_s
    from = input.to_s.split("-")[0].to_i
    to = input.to_s.split("-")[1].to_i

    if (input.match(/[-]/) != nil) && (from.between?(1, 100)) && (to.between?(1, 100))
      print_paintings(input)
      select_painting?
    elsif (input.match(/[-]/) != nil) && !(from.between?(1, 100)) && (to.between?(1, 100))
      puts ""
      puts "Invalid entry. Please try again."
      start
    elsif (input.match(/[-]/) != nil) && (from.between?(1, 100)) && !(to.between?(1, 100))
      puts ""
      puts "Invalid entry. Please try again."
      start
    elsif (input.match(/[-]/) != nil) && !(from.between?(1, 100)) && !(to.between?(1, 100))
      puts ""
      puts "Invalid entry. Please try again."
      start
    elsif input.to_i.between?(1, 100)
      painting = MostFamousPaintings::Painting.find(input.to_i)
      print_painting(painting)
      puts ""
      puts "Would you like to see more paintings? Please enter 'yes' or 'no'."
      play_again
    else
      puts ""
      puts "Invalid entry. Please try again."
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
      puts ""
      puts "Invalid entry. Please enter 'yes' or 'no'."
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
    puts "----- ##{painting.ranking} - #{painting.title.upcase} -----"
    puts ""
    puts "Painter | Medium:  #{painting.painter_medium_size}"
    puts "#{painting.description}"
  end

  def select_painting?
    puts ""
    puts "If you want more information on a specific painting, please enter its ranking number or interval. For example, you may enter '1' or '1-20'. You can also enter 'exit' to end the program."
    input = gets.strip.to_s
    from = input.to_s.split("-")[0].to_i
    to = input.to_s.split("-")[1].to_i

    if (input.match(/[-]/) != nil) && (from.between?(1, 100)) && (to.between?(1, 100))
      print_paintings(input)
      select_painting?
    elsif (input.match(/[-]/) != nil) && !(from.between?(1, 100)) && (to.between?(1, 100))
      puts ""
      puts "Invalid entry. Please try again."
      start
    elsif (input.match(/[-]/) != nil) && (from.between?(1, 100)) && !(to.between?(1, 100))
      puts ""
      puts "Invalid entry. Please try again."
      start
    elsif (input.match(/[-]/) != nil) && !(from.between?(1, 100)) && !(to.between?(1, 100))
      puts ""
      puts "Invalid entry. Please try again."
      start
    elsif input.to_i.between?(1, 100)
      painting = MostFamousPaintings::Painting.find(input.to_i)
      print_painting(painting)
      puts ""
      puts "Would you like to see more paintings? Please enter 'yes' or 'no'."
      play_again
    elsif input.to_s == "exit"
      puts "Thank you for playing. Please come back to play again soon!"
    else
      puts ""
      puts "Invalid entry."
      select_painting?
    end
  end

end
