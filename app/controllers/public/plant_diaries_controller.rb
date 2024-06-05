class Public::PlantDiariesController < ApplicationController

  def new
    @plant_diary = PlantDiary.new
  end

  def index
    @plant_diaries = PlantDiary.all
  end

  def show
    @plant_diary = PlantDiary.find(params[:id])
  end

  def create
  @plant_diary = PlantDiary.new(plant_diary_params)
  
    if current_user.nil?
      Rails.logger.debug("current_user is nil")
      flash[:alert] = 'ユーザーがログインしていません。'
      redirect_to new_user_session_path and return
    else
      Rails.logger.debug("current_user is present: #{current_user.id}")
    end
    
    @plant_diary.user_id = current_user.id
    
    if @plant_diary.save
      flash[:notice] = '投稿に成功しました.'
      redirect_to @plant_diary
    else
      flash[:alert] = @plant_diary.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
    @plant_diary = PlantDiary.find(params[:id])
  end

  def update
    if @plant_diary.update(plant_diary_params)
      flash[:notice] = '更新に成功しました.'
      redirect_to @plant_diary
    else
      flash[:alert] = @plant_diary.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    @plant_diary = PlantDiary.find(params[:id])
    @plant_diary.destroy
    flash[:notice] = '投稿が削除されました.'
    redirect_to plant_diaries_url
  end

  private

  def set_plant_diary
    @plant_diary = PlantDiary.find(params[:id])
  end

  def plant_diary_params
    params.require(:plant_diary).permit(:title, :content, :user_id, :image)
  end
end