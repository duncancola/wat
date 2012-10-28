require File.expand_path(File.dirname(__FILE__) + '/does_requests.rb')

class SevenDigitalRest
  BASE_URL = "http://api.7digital.com/1.2/"
  CONSUMER_KEY = "musichackday"
  JSON = "&format=json"
  DEFAULT_NUMBER_OF_RESULTS = "&pageSize=30"
  COVER_IMAGE_SIZE = "&imageSize=350"
  ARTIST_IMAGE_SIZE = "&imageSize=200"

  def initialize(does_http_requests)
    @does_requests = does_http_requests
  end

  def get_artists_for_genre(genre)
    @does_requests.get(BASE_URL + "artist/bytag/top?tags=" + genre + "&oauth_consumer_key=" + CONSUMER_KEY + DEFAULT_NUMBER_OF_RESULTS + ARTIST_IMAGE_SIZE)
  end

  def get_releases(artist_id)
    @does_requests.get(BASE_URL + "artist/releases?artistid=" + artist_id + "&oauth_consumer_key=" + CONSUMER_KEY + COVER_IMAGE_SIZE)
  end

   def get_tracks(release_id)
    @does_requests.get(BASE_URL + "release/tracks?releaseid=" + release_id + "&oauth_consumer_key=" + CONSUMER_KEY)
   end

  def get_track_preview(track_id)
    @does_requests.get(BASE_URL + "track/preview?trackid=" + track_id + "&oauth_consumer_key=" + CONSUMER_KEY)
  end
end

