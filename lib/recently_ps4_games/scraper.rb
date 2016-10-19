require 'pry'
require 'open-uri'
require 'nokogiri'
require 'watir-webdriver'
require 'phantomjs'

module RecentlyPs4Games
end


class RecentlyPs4Games::Scraper

  def self.get_dynamic_page_html(url)
    Selenium::WebDriver::PhantomJS.path = Phantomjs.path
    browser = Watir::Browser.new(:phantomjs)
    browser.goto url
    browser.html
  end

  def self.iterate_over_games_XML(games_XML)
    games_arr = []
    games_XML.each do |game|
      games_arr << {
        title: game.text,
        detail_url: game.attr("href")
      }
    end
    games_arr
  end

  def self.scrape_new_list(url)
    list_page = Nokogiri::HTML(self.get_dynamic_page_html(url))
    new_game_grid = list_page.css("div.inlineTabs.section.gameGrid").first
    new_games = new_game_grid.css("ul.clearfix li.layout-type-1 div.tile.clearfix div.game-tile-details h2 a.title")

    self.iterate_over_games_XML(new_games)
  end

  def self.scrape_upcoming_list(url)
    list_page = Nokogiri::HTML(self.get_dynamic_page_html(url))
    upcoming_game_grid = list_page.css("div.inlineTabs.section.gameGrid")[1]
    upcoming_games = upcoming_game_grid.css("ul.clearfix li.layout-type-1 div.tile.clearfix div.game-tile-details h2 a.title")

    self.iterate_over_games_XML(upcoming_games)
  end



end

RecentlyPs4Games::Scraper.new.class.scrape_upcoming_list("https://www.playstation.com/en-us/explore/games/ps4-games/")
