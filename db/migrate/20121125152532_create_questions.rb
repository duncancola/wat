class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :options_type
      t.string :song_url
      t.string :option1
      t.string :option2
      t.string :option3
      t.string :answer
      t.string :question_text
      t.string :artist_image

      t.timestamps
    end
  end
end
