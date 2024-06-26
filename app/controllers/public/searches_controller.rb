class Public::SearchesController < ApplicationController

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
     
      flash[:alert] = "指定された範囲はサポートされていません。"
      redirect_to root_path and return
    end
  end
    # def search_tag
  #   @tag = Tag.find(params[:tag_id])
  #   @plant_diaries = @tag.plant_diaries.includes(:user, :tags).where(users: { is_active: true })
  #   @tags = Tag.all
  #   render 'public/plant_diaries/search_tag'
  # end
end