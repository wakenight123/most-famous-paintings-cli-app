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
    puts "Would you like to search for a painting by painter, title or ranking?"
    input = gets.strip.downcase
    if input == "painter" || "by painter"
      puts ""
      puts "Please enter the name of the painter."
      search_by_painter
    elsif input == "title" || "by title"
      puts ""
      puts "Please enter the title of the painting."
      search_by_title
    else
      puts ""
      puts "Invalid form of search. Please try again."
      search
    end
  end
