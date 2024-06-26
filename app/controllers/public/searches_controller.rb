class Public::SearchesController < ApplicationController

  def search
    @word = params[:word]
    @range = params[:range]

    if @range == "ユーザー"
      @users = User.looks(@word)
    elsif @range == "コミュニティ"
      @communities = Community.looks(@word)
    elsif @range == "育成記録"
      @tag = Tag.find(params[:tag_id])
      @plant_diaries = PlantDiary.looks(@word)
    end
  end
end
