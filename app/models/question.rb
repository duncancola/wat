class Question < ActiveRecord::Base

  def as_json
    { :type => @options_type,
      :song_url => @song_url,
      :options => [{:id => 1, :content => @option1},
                   {:id => 2, :content => @option2},
                   {:id => 3, :content => @option3}
                  ],
      :answer => @answer,
      :text => @question_text,
      :image => @artist_image }
  end

end
