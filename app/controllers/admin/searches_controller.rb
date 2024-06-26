class Admin::SearchesController < ApplicationController

  def search
    @word = params[:word]
    @range = params[:range]

    case @range
    when "ユーザー"
      @users = User.looks(@word)
    when "コミュニティ"
      @communities = Community.looks(@word)
    when "育成記録"
      @plant_diaries = PlantDiary.looks(@word)
    else
    end
  end
end