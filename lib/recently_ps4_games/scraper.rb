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

  def self.scrape_details(url)
    detail_page = Nokogiri::HTML(open(url))
    prod_meta = detail_page.css("div.prod-meta")
    release_info = prod_meta.css("ul.release-info li")

    details = {
      discription: prod_meta.css("p.teaser").text,
      release_date: release_info.css("span.releasedate").text.delete("\n\t"),
      genre: release_info[1].children[2].text.delete("\n\t"),
      publisher: release_info[2].children[1].text.delete("\n\t"),
      developer: release_info[3].children[1].text.delete("\n\t")
    }

    details
  end

end
