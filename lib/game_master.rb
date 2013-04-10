class GameMaster
  unloadable 

  def self.register_new_game(game_id, genre)
  end

  def self.get_questions(game_id, exclude)
    all_questions = Game.find_by_uuid(game_id).questions
    if exclude
      all_questions.delete_if { |question| exclude.include?(question.number.to_s) }
    else
      all_questions
    end
  end

end
