class RecentlyPs4Games::Scraper

  def self.get_dynamic_page_html
    Selenium::WebDriver::PhantomJS.path = Phantomjs.path
    browser = Watir::Browser.new(:phantomjs)
    browser.goto "https://www.playstation.com/en-us/explore/games/ps4-games/"
    browser.html
  end

  def self.scrape_game_list
    list_page = Nokogiri::HTML(self.get_dynamic_page_html)
    game_grids = list_page.css("div.inlineTabs.section.gameGrid")
    game_grids.each do |game_grid|
      games = game_grid.css("ul.clearfix li.layout-type-1 div.tile.clearfix div.game-tile-details h2 a.title")
      games.each do |game|
        RecentlyPs4Games::Game.new({
          title: game.text,
          detail_url: game.attr("href")
        })
      end
    end
  end

  def self.scrape_details(game)
    detail_page = Nokogiri::HTML(open(game.detail_url))
    prod_meta = detail_page.css("div.prod-meta")
    release_info = prod_meta.css("ul.release-info li")
    game.add_attributes({
      discription: prod_meta.css("p.teaser").text,
      release_date: release_info.css("span.releasedate").text.delete("\n\t"),
      genre: release_info[1].children[2].text.delete("\n\t"),
      publisher: release_info[2].children[1].text.delete("\n\t"),
      developer: release_info[3].children[1].text.delete("\n\t")
    })
    game
  end

end
