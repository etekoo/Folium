class Admin::PlantDiariesController < ApplicationController
  before_action :set_plant_diary, only: [:show, :edit, :update, :destroy]

  def index
     @plant_diaries = PlantDiary.all
  end

  def show
    @comment = Comment.new
  end

  def destroy
    @plant_diary.destroy
    flash[:notice] = '投稿が削除されました.'
    redirect_to plant_diaries_url
  end
  
  def edit
  end
  
  private

  def set_plant_diary
    @plant_diary = PlantDiary.find(params[:id])
  end

  def plant_diary_params
    params.require(:plant_diary).permit(:title, :content, :user_id, :image)
  end
  
end
