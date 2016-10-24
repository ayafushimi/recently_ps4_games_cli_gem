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

  def ask_what_to_detail
    puts "What game would you like to get details?"
    puts "Please input NUMBER."
    input = gets.strip.to_i
    until input.between?(1, RecentlyPs4Games::Game.all.size) do
      puts "Please input valid NUMBER."
      input = gets.strip.to_i
    end
    input
  end

  def get_detail(id)
    game = RecentlyPs4Games::Game.find_by_id(id)
    detail = RecentlyPs4Games::Scraper.scrape_details(game.detail_url)
    game.add_attributes(detail)
  end

  def display_detail(game)
    puts ""
    puts "-------------------------------"
    puts "\e[1m#{game.id}. #{game.title}\e[0m"
    puts ""
    puts "#{game.discription}"
    puts ""
    puts "\e[2mRelease date : \e[0m #{game.release_date}"
    puts "\e[2mGenre        : \e[0m #{game.genre}"
    puts "\e[2mPublisher    : \e[0m #{game.publisher}"
    puts "\e[2mDeveloper    : \e[0m #{game.developer}"
    puts "-------------------------------"
    puts ""
  end

  def ask_exit?
    puts "Do you want to exit? (y/n)"
    input = gets.strip
    until input == "y" || input == "n" do
      puts "Do you want to exit? (y/n)"
      puts "Please input 'y' to exit, 'n' to continue."
      input = gets.strip
    end
    if input == "y"
      true
    elsif input == "n"
      false
    end
  end

end
