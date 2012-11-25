require 'music_factory'
require 'game_master'
class FastController < ApplicationController

  respond_to :json
  def index

    game_id = request.uuid
    GameMaster.register_new_game(game_id, params[:genre])

    respond_with(@questions) do |format|
      format.json { render :json => "{game_id : #{game_id}}"}
    end
  end
end
