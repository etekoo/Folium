class Admin::SearchesController < ApplicationController
  
  def search
    @word = params[:word]
    @search = params[:search]
    @range = params[:range]

    if @range == "ユーザー"
      @users = User.looks(@search, @word)
    elsif @range == "書籍"
      @books = Book.looks(@search, @word)
    elsif @range == "日記"
      @plant_diaries = PlantDiary.looks(@search, @word)
    end
  end
  
end
