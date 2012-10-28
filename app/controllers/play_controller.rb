require 'music_factory'
require 'dj'
class PlayController < ApplicationController

  respond_to :json
  def index
    mf = MusicFactory.new(SevenDigitalRest.new(DoesRequests.new))
    artists = mf.get_artists_single_track("rock")
    dj = Dj.new
    @questions = dj.create_questions(artists)
    respond_with(@questions) do |format|
      format.json { render :json => @questions.to_json() }
    end
  end
end
