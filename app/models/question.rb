class Question < ActiveRecord::Base
  attr_accessible :number, :type, :song_url, :options, :answer, :text, :image, :game_id

  belongs_to :game

  def as_json
    { :number => self.number,
      :type => self.options_type,
      :song_url => self.song_url,
      :options => [{:id => 1, :content => self.option1},
                   {:id => 2, :content => self.option2},
                   {:id => 3, :content => self.option3}
                  ],
      :answer => self.answer,
      :text => self.question_text,
      :image => self.artist_image }
  end

end
