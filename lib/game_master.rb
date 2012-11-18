class GameMaster
  @@games = {}

  def self.register_new_game(genre)
    id = generate_id()
    @@games[id] = nil
    #start_game(id)
    id
  end

  def self.generate_id
    id = Time.now.to_i
    while @@games.include?(id) do
      id = Time.now.to_i
    end
    id
  end
end

100.times { puts GameMaster.register_new_game("rock") }
