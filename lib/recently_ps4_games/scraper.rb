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
    games = []
    list_page = Nokogiri::HTML(self.get_dynamic_page_html(url))
    game_grid = list_page.css("div.inlineTabs.section.gameGrid").first

    binding.pry
    # list_page.css("div.gameGrid")
    # game = game_grid.css("ul.clearfix li.layout-type-1")


  end

end

RecentlyPs4Games::Scraper.new.class.scrape_new_list("https://www.playstation.com/en-us/explore/games/ps4-games/")
