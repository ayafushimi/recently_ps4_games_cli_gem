module RecentlyPs4Games
end


class RecentlyPs4Games::Cli

  def call
    
  end

end

# games_arr = RecentlyPs4Games::Scraper.scrape_new_list("https://www.playstation.com/en-us/explore/games/ps4-games/")
#
# RecentlyPs4Games::Game.create_by_games_arr(games_arr)
# game = RecentlyPs4Games::Game.find_by_id(2)
# details = RecentlyPs4Games::Scraper.scrape_details(game.detail_url)
# game.add_attributes(details)
