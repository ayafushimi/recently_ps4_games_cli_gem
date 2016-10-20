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
    display_detail(get_detail(ask_what_to_detail))
    interact_with_user unless ask_exit?
  end

  def display_list
    RecentlyPs4Games::Game.all.each do |game|
      puts "#{game.id}. #{game.title}"
    end
  end

  def get_detail(id)
    game = RecentlyPs4Games::Game.find_by_id(id)
    detail = RecentlyPs4Games::Scraper.scrape_details(game.detail_url)
    game.add_attributes(detail)
  end

  def display_detail(game)
    puts "-------------------------------"
    puts ""
    puts "#{game.id}. \e[1m#{game.title}"
    puts "#{discription}"
    puts ""
    puts "\e[1mRelease date:\e[0m #{game.release_date}"
    puts "\e[1mGenre       :\e[0 #{game.genre}"
    puts "\e[1mPublisher   :\e[0 #{game.publisher}"
    puts "\e[1mDeveloper   :\e[0 #{game.developer}"
    puts ""
    puts "-------------------------------"
  end

end

# games_arr = RecentlyPs4Games::Scraper.scrape_new_list("https://www.playstation.com/en-us/explore/games/ps4-games/")
#
# RecentlyPs4Games::Game.create_by_games_arr(games_arr)
# game = RecentlyPs4Games::Game.find_by_id(2)
# details = RecentlyPs4Games::Scraper.scrape_details(game.detail_url)
# game.add_attributes(details)
