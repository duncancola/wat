class GameMaster
  @@games = {}

  def self.register_new_game(genre)
    id = generate_id()
    start_game(id)
  end

  def self.generate_id
    while @@games.include?(id) do
      id = Time.now.to_i
    end
    id
  end
end
