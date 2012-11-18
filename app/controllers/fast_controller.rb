require 'music_factory'
require 'game_master'
class FastController < ApplicationController

  respond_to :json
  def index
    game_id = GameMaster.register_new_game(params[:genre])

    respond_with(@questions) do |format|
      format.json { render :json => "{game_id : #{game_id}}"}
    end
  end
end
