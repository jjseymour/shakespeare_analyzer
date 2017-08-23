class HomeController < ApplicationController
  def new
  end

  def create
    play_obj = IbiblioXML.new(params[:url]).run
    respond_to do |format|
      if play_obj.error
        format.json { render json: { errors: play_obj.error }, status: 404 }
      end
      format.html { redirect_to(plays_path(Play.all.find_index(play_obj))) }
      format.json { render json: PlaySerializer.serialize(play_obj) }
    end
  end
end
