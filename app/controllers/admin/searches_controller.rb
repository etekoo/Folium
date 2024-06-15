class Admin::SearchesController < ApplicationController
  
  def search
    @word = params[:word]
    @range = params[:range]

    if @range == "ユーザー"
      @users = User.looks(@word)
    elsif @range == "書籍"
      @books = Book.looks(@word)
    elsif @range == "日記"
      @plant_diaries = PlantDiary.looks(@word)
    end
  end
  
end
