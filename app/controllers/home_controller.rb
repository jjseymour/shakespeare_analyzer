class HomeController < ApplicationController
  def new
  end

  def create
    play_obj = IbiblioXML.new(params[:url]).run
    respond_to do |format|
      if play_obj.is_a?(Hash)
        format.json { render json: play_obj, status: 404 }
      end
      format.html { redirect_to(home_path) }
      format.json { render json: PlaySerializer.serialize(play_obj) }
    end
  end
end
