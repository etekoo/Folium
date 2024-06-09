class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_plant_diary, only: [:create, :destroy]

  def create
    @comment = @plant_diary.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to plant_diary_path(@plant_diary), notice: 'コメントが追加されました。'
    else
      redirect_to plant_diary_path(@plant_diary), alert: 'コメントの追加に失敗しました。'
    end
  end

  def destroy
    @comment = @plant_diary.comments.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      redirect_to plant_diary_path(@plant_diary), notice: 'コメントが削除されました。'
    else
      redirect_to plant_diary_path(@plant_diary), alert: 'コメントの削除に失敗しました。'
    end
  end

  private

  def set_plant_diary
    @plant_diary = PlantDiary.find(params[:plant_diary_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end