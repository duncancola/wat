require 'oauth'
require File.expand_path(File.dirname(__FILE__) + '/does_requests.rb')

class SevenDigitalRest
  BASE_URL = "http://api.7digital.com/1.2/"
  CONSUMER_KEY = "musichackday"
  JSON = "&format=json"

  def initialize(does_http_requests)
    @does_requests = does_http_requests
  end

  def get_artists_for_genre(genre)
    @does_requests.get(BASE_URL + "artist/bytag/top?tags=" + genre + "&oauth_consumer_key=" + CONSUMER_KEY + JSON)
  end

  def get_releases(artist_id)
    @does_requests.get(BASE_URL + "artist/releases?artistid=" + artist_id + "&oauth_consumer_key=" + CONSUMER_KEY)
  end

  def get_track_preview(track_id)
    @does_requests.get(BASE_URL + "track/preview?trackid=" + track_id + "&oauth_consumer_key=" + CONSUMER_KEY)
  end

end

rest = SevenDigitalRest.new(DoesRequests.new)
print rest.get_artists_for_genre("rock").body
