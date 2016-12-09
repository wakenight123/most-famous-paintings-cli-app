require_relative "../lib/scraper.rb"
require_relative "../lib/painting.rb"
require_relative "../lib/painter.rb"
require 'nokogiri'

class Cli

  def call
    start
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
    if input == "painter" || "by painter"
      puts ""
      puts "Please enter the name of the painter."
      search_by_painter
    elsif input == "title" || "by title"
      puts ""
      puts "Please enter the title of the painting."
      search_by_title
    elsif input == "rank" || "by rank"
      search_by_rank
    else
      puts ""
      puts "Invalid form of search. Please try again."
      search
    end
  end

  def search_by_painter
    input = gets.strip.downcase
    if painter.list_all_painters.detect{|painter| painter.downcase == input} != nil
      puts ""
      puts "#{painter}(#{painter.painter_nationality}) has #{painter.titles.count} paintings that are included in The Most Famous Paintings of All-Time:"
      puts ""
      painter.titles.each do |painting|
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
    if painting.list_all_painting_titles.detect{|painting| painting.downcase == input} != nil
      puts ""
      puts "'#{painting}' is ranked ##{painting.ranking} in this list of The Most Famous Paintings of All-Time."
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
    puts "Please choose paintings ranked from 1-10, 11-20, 21-30, 31-40, 41-50, 51-60, 61-70, 71-80, 81-90 or 91-100."
    input = gets.strip.to_s
    if input != "1-10" || "11-20" || "21-30" || "31-40" || "41-50" || "51-60" || "61-70" || "71-80" || "81-90" || "91-100"
      puts "Invalid entry. Please try again."
      puts ""
      search_by_rank
    else
      from = input.split("-")[0].to_i
      to = input.split("-")[1].to_i
      puts ""
      puts "----- Paintings ranked # #{from} - #{to} -----"

      painting.list_all_painting_titles[from-1 ,10].each_with_index do |painting, index|
        puts "#{index}. '#{painting.title}' by #{painting.painter}(#{painting.painter_nationality}), #{painting.time_period}"
        end
      puts ""
      puts "Would you like to search for more paintings?"
      play_again
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
