module RecentlyPs4Games
end

class RecentlyPs4Games::Game
  attr_accessor :id, :title, :detail_url, :discription, :release_date, :genre, :publisher, :developer

  @@all = []

  def initialize(game_hash)
    game_hash.each do |k, v|
      self.send("#{k}=", v)
    end
    @@all << self
    @id = @@all.size
    self
  end

  def self.create_by_games_arr(games_arr)
    games_arr.each do |game|
      self.new(game)
    end

    binding.pry
  end

  def self.get_detail_url_from_id(id)
    self.all.detect do |game|
      game.id == id
    end.detail_url
  end

  def add_attributes(details_hash)
    details_hash.each do |k, v|
      self.send("#{k}=", v)
    end
    self
  end

  def self.all
    @@all
  end

end
