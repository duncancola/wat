class PlayController < ApplicationController

  respond_to :json
  def index
    @questions = [{
      :id => 1337, 
      :type => "text", 
      :song_url => "", 
      :options => [{:id => 1, :content => "a"}, 
                   {:id => 2, :content => "b"},
                   {:id => 3, :content => "c"}], 
      :answer => 2,
      :text => "Choose your destiny",
      }]
    respond_with(@questions) do |format|
      format.json { render :json => @questions.to_json() }
    end
  end
end
