require 'game_master'
class PlayController < ApplicationController

  respond_to :json
  def index
    @questions = GameMaster.get_questions(params[:game_id],
                                          params[:exclude])

    respond_with(@questions) do |format|
      format.json { render :json => @questions.as_json() }
    end
  end
end
