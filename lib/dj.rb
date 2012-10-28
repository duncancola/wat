require File.expand_path(File.dirname(__FILE__) + '/music_factory.rb')

class Dj
  def create_questions(artists)
    artists.shuffle!
    grouped_artists = artists.each_slice(3).to_a
    questions = []
    grouped_artists.each do |artist_group|
      questions << create_basic_question(artist_group)
    end
    questions
  end

  def create_basic_question(artist_group)
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
end

mf = MusicFactory.new(SevenDigitalRest.new(DoesRequests.new))
artists = mf.get_artists_single_track("rock")

dj = Dj.new
q = dj.create_questions(artists)
puts "aafaefaef"
puts q
puts "zz"
