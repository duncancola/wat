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
    create_question(artist_group[0].name,
                    artist_group[1].name,
                    artist_group[2].name,
                    "text",
                    preview,
                    correct_answer,
                    "What artist is this?",
                    correct_artist.image)
  end

  def create_song_question(artist_group)
    correct_answer = rand(3)
    correct_artist = artist_group[correct_answer]
    preview = correct_artist.releases.tracks.preview
    create_question(artist_group[0].releases.tracks.title,
                    artist_group[1].releases.tracks.title,
                    artist_group[2].releases.tracks.title,
                    "text",
                    preview,
                    correct_answer,
                    "What song is this?",
                    correct_artist.image)
  end

  def create_album_question(artist_group)
    correct_answer = rand(3)
    correct_artist = artist_group[correct_answer]
    preview = correct_artist.releases.tracks.preview
    create_question(artist_group[0].releases.image,
                    artist_group[1].releases.image,
                    artist_group[2].releases.image,
                    "image",
                    preview,
                    correct_answer,
                    "What album is this song from?",
                    correct_artist.image)
  end

  def create_question(content_0, 
                      content_1,
                      content_2,
                      type, 
                      preview, 
                      correct_answer, 
                      text,
                      image)
    {
		:type => type,
		:song_url => preview,
		:options => [{:id => 0, :content => content_0},
					 {:id => 1, :content => content_1},
					 {:id => 2, :content => content_2}
					],
		:answer => correct_answer,
		:text => text,
        :image => image
	}
  end
end
