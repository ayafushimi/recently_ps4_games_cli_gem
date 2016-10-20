module RecentlyPs4Games
end


class RecentlyPs4Games::Cli

  def call
    puts "Welcome to recently_ps4_games!!"
    puts "...now makinging games list..."
    make_games # as Game Instance
    interact_with_user # display list, ask input, display details
    puts "Bye!"
  end

  def make_games
    games_arr = RecentlyPs4Games::Scraper.scrape_game_list
    RecentlyPs4Games::Game.create_by_games_arr(games_arr)
  end

  def interact_with_user
    display_list
    display_detail(ask_what_to_detail)
    interact_with_user unless ask_exit?
  end

end

# games_arr = RecentlyPs4Games::Scraper.scrape_new_list("https://www.playstation.com/en-us/explore/games/ps4-games/")
#
# RecentlyPs4Games::Game.create_by_games_arr(games_arr)
# game = RecentlyPs4Games::Game.find_by_id(2)
# details = RecentlyPs4Games::Scraper.scrape_details(game.detail_url)
# game.add_attributes(details)
