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
      redirect_to @plant_diary, notice: 'Plant diary was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @plant_diary.update(plant_diary_params)
      redirect_to @plant_diary, notice: 'Plant diary was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @plant_diary.destroy
    redirect_to plant_diaries_url, notice: 'Plant diary was successfully destroyed.'
  end

  private

  def set_plant_diary
    @plant_diary = PlantDiary.find(params[:id])
  end

  def plant_diary_params
    params.require(:plant_diary).permit(:title, :content, :user_id)
  end
end