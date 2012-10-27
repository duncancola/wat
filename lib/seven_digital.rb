require 'sevendigital'
class SevenDigital

  def initialize(api_client)
    @api_client = api_client
  end

  def get_artist(name)
    an_artist = api_client.artist.search(name).first

    print "releases = #{an_artist.releases}"
    a_release = an_artist.releases.sort_by{|release| release.year}.last

    puts "the latest #{an_artist.name} release is #{a_release.title} from #{a_release.year}"

    puts "go and buy it at #{a_release.url} !"
  end

  def get_artists_for_genre(genre)
    @api_client.artist.get_top_by_tag(genre)
  end

end


api_client = Sevendigital::Client.new(:oauth_consumer_key => "musichackday", 
                                      :oauth_consumer_secret => "C2uS4enU96agunaF", 
                                      :country => 'GB', 
                                      :verbose => true)

seven_digital = SevenDigital.new(api_client)
print seven_digital.get_artists_for_genre("rock")
