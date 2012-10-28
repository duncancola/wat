require File.expand_path(File.dirname(__FILE__) + '/music_factory.rb')

class Dj
  def create_questions(artists)
    artists.shuffle!
    grouped_artists = artists.each_slice(3).to_a
    questions = []
    grouped_artists.each do |artist_group|
      questions << create_random_question(artist_group)
    end
    questions
  end

  def create_random_question(artist_group)
    question_type = rand(3)
    case question_type
    when 0
      return create_artist_question(artist_group)
    when 1
      return create_song_question(artist_group)
    when 2
      return create_album_question(artist_group)
    else
      puts "wat"
    end
  end

  def create_artist_question(artist_group)
    correct_answer = rand(3)
    correct_artist = artist_group[correct_answer]
    preview = correct_artist.releases.tracks.preview
    {
		:type => "text",
		:song_url => preview,
		:options => [{:id => 0, :content => artist_group[0].name},
					 {:id => 1, :content => artist_group[1].name},
					 {:id => 2, :content => artist_group[2].name}
					],
		:answer => correct_answer,
		:text => "What artist is this?"
	}
  end

  def create_song_question(artist_group)
    correct_answer = rand(3)
    correct_artist = artist_group[correct_answer]
    preview = correct_artist.releases.tracks.preview
    {
		:type => "text",
		:song_url => preview,
		:options => [{:id => 0, :content => artist_group[0].releases.tracks.title},
					 {:id => 1, :content => artist_group[1].releases.tracks.title},
					 {:id => 2, :content => artist_group[2].releases.tracks.title}
					],
		:answer => correct_answer,
		:text => "What song is this?"
	}
  end

  def create_song_question(artist_group)
    correct_answer = rand(3)
    correct_artist = artist_group[correct_answer]
    preview = correct_artist.releases.tracks.preview
    {
		:type => "text",
		:song_url => preview,
		:options => [{:id => 0, :content => artist_group[0].releases.tracks.title},
					 {:id => 1, :content => artist_group[1].releases.tracks.title},
					 {:id => 2, :content => artist_group[2].releases.tracks.title}
					],
		:answer => correct_answer,
		:text => "What song is this?"
	}
  end

  def create_album_question(artist_group)
    correct_answer = rand(3)
    correct_artist = artist_group[correct_answer]
    preview = correct_artist.releases.tracks.preview
    {
		:type => "image",
		:song_url => preview,
		:options => [{:id => 0, :content => artist_group[0].releases.image},
					 {:id => 1, :content => artist_group[1].releases.image},
					 {:id => 2, :content => artist_group[2].releases.image}
					],
		:answer => correct_answer,
		:text => "What album is this song from?"
	}
  end

end
