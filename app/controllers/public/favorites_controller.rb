class Public::FavoritesController < ApplicationController

  def create
    @plant_diary = PlantDiary.find(params[:plant_diary_id])
    favorite = @plant_diary.favorites.new(user_id: current_user.id)
    favorite.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @plant_diary = PlantDiary.find(params[:plant_diary_id])
    favorite = current_user.favorites.find_by(plant_diary_id: @plant_diary.id)
    favorite.destroy
    redirect_back(fallback_location: root_path)
  end



end
