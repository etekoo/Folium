class Admin::PlantDiariesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_plant_diary, only: [:show, :edit, :update, :destroy]
  before_action :user_is_active, only: [:show]



  def index
    @plant_diaries = PlantDiary.all
  end

  def show
    @comment = Comment.new
  end

  def destroy
    @plant_diary = PlantDiary.find(params[:id])
    @plant_diary.destroy
    flash[:notice] = '投稿が削除されました.'
    redirect_to admin_plant_diaries_url
  end

  def edit
  end

  private

  def set_plant_diary
    @plant_diary = PlantDiary.find(params[:id])
  end

  def user_is_active
    @plant_diary = PlantDiary.find(params[:id])
    user = @plant_diary.user
    if user && !user.is_active?
      redirect_to root_path, alert: 'この投稿は無効なユーザーによって作成されました。'
    end
  end

  def plant_diary_params
    params.require(:plant_diary).permit(:title, :content, :user_id, :image)
  end

end
