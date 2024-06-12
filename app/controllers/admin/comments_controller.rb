class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_plant_diary, only: [:destroy]



  def destroy
    @comment = @plant_diary.comments.find(params[:id])
    if 
      @comment.destroy
      redirect_to admin_plant_diary_path(@plant_diary), notice: 'コメントが削除されました。'
    else
      redirect_to admin_plant_diary_path(@plant_diary), alert: 'コメントの削除に失敗しました。'
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