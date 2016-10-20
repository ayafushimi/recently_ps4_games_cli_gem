require 'pry'
require 'open-uri'
require 'nokogiri'
require 'watir-webdriver'
require 'phantomjs'

# require_relative "recently_ps4_games/cli.rb"
require_relative "recently_ps4_games/game.rb"
require_relative "recently_ps4_games/scraper.rb"
require_relative "recently_ps4_games/version.rb"

module RecentlyPs4Games
end

games_arr = RecentlyPs4Games::Scraper.scrape_new_list("https://www.playstation.com/en-us/explore/games/ps4-games/")

RecentlyPs4Games::Game.create_by_games_arr(games_arr)
RecentlyPs4Games::Game.get_detail_url_from_id(2)
