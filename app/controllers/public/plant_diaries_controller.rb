class Public::PlantDiariesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_plant_diary, only: [:show, :edit, :update, :destroy]
  before_action :filter_activeUser, only: [:show]
  before_action :confirm_owner, only: [:edit, :update, :destroy]

  def new
    @plant_diary = PlantDiary.new
  end

  def index
    @plant_diaries = PlantDiary.includes(:user).where(users: { is_active: true })
  end

  def show
   @comment = Comment.new
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

  # 無効なユーザーの投稿を除外
  def filter_activeUser
    user = @plant_diary.user
    if user.is_active?
    else
      flash[:alert] = "指定のユーザーは退会済みです"
      redirect_to mypage_path
    end
  end

    # ログインユーザーが投稿者かどうか確認
  def confirm_owner
    unless @plant_diary.user == current_user
      flash[:alert] = "編集または削除する権限がありません"
      redirect_to plant_diaries_path
    end
  end

  def plant_diary_params
    params.require(:plant_diary).permit(:title, :content, :user_id, :image)
  end
end