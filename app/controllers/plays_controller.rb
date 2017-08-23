class PlaysController < ApplicationController
  def show
    @play = Play.find_by_index(params[:id].to_i)
  end
end
