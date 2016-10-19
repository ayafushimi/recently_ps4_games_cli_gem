require 'pry'
require 'open-uri'
require 'nokogiri'

module RecentlyPs4Games
end


class RecentlyPs4Games::Scraper
  def self.scrape_list(url)
    games = []
    list_page = Nokogiri::HTML(open(url))
    game_grid = list_page.css("div.gameGrid")

    binding.pry
    # list_page.css("div.gameGrid")
    # game = game_grid.css("div div div ul li div.game-tile div.tile.clearfix")


  end

end

RecentlyPs4Games::Scraper.new.class.scrape_list("https://www.playstation.com/en-us/explore/games/ps4-games/")
