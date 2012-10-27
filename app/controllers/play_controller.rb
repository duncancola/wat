class PlayController < ApplicationController
  def index
    @questions = {"type" => "lulz"}

    respond_with(@questions) do |format|
      format.json { render :json => @questions.to_json() }
    end
  end
end
