class AddGameIdToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :game_id, :string
  end
end
