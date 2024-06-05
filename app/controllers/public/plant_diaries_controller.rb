class Public::PlantDiariesController < ApplicationController
  before_action :set_plant_diary, only: [:show, :edit, :update, :destroy]

  def new
    @plant_diary = PlantDiary.new
  end

  def index
    @plant_diaries = PlantDiary.all
  end

  def show
  end

  def create
    @plant_diary = PlantDiary.new(plant_diary_params)
    if @plant_diary.save
      flash[:notice] = '投稿に成功しました.'
      redirect_to @plant_diary
    else
      flash[:alert] = @plant_diary.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
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
    @plant_diary.destroy
    flash[:notice] = '投稿が削除されました.'
    redirect_to plant_diaries_url
  end

  private

  def set_plant_diary
    @plant_diary = PlantDiary.find(params[:id])
  end

  def plant_diary_params
    params.require(:plant_diary).permit(:title, :content, :user_id)
  end
end