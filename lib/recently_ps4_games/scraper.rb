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

  def self.scrape_new_list(url)
    new_games_arr = []
    list_page = Nokogiri::HTML(self.get_dynamic_page_html(url))
    new_game_grid = list_page.css("div.inlineTabs.section.gameGrid").first
    new_games = new_game_grid.css("ul.clearfix li.layout-type-1 div.tile.clearfix div.game-tile-details h2 a.title")

    new_games.each do |new_game|
      new_games_arr << {
        title: new_game.text,
        detail_url: new_game.attr("href")
      }
    end
    new_games_arr
  end

end

RecentlyPs4Games::Scraper.new.class.scrape_new_list("https://www.playstation.com/en-us/explore/games/ps4-games/")
