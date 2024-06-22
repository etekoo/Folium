class Public::PlantDiariesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_plant_diary, only: [:show, :edit, :update, :destroy]
  before_action :filter_activeUser, only: [:show]
  before_action :confirm_owner, only: [:edit, :update, :destroy]

  def new
    @plant_diary = PlantDiary.new
  end

  def index
    @plant_diaries = PlantDiary.includes(:user, :tags).where(users: { is_active: true })
    @tags = Tag.all
  end

  def show
    @comment = Comment.new
    @tag_list = @plant_diary.tags.pluck(:name).join(',')
    @plant_diary_tags = @plant_diary.tags
  end

  def create
    @plant_diary = PlantDiary.new(plant_diary_params)
    tag_list = params[:plant_diary][:tags].split(',') if params[:plant_diary][:tags]

    if current_user.nil?
      Rails.logger.debug("current_user is nil")
      flash[:alert] = 'ユーザーがログインしていません。'
      redirect_to new_user_session_path and return
    else
      Rails.logger.debug("current_user is present: #{current_user.id}")
    end

    @plant_diary.user_id = current_user.id

    if @plant_diary.save
      @plant_diary.save_plan_tags(tag_list)
      flash[:notice] = '投稿に成功しました.'
      redirect_to @plant_diary
    else
      flash[:alert] = @plant_diary.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
    @tag_list = @plant_diary.tags.pluck(:name).join(',')
  end

  def update
    tag_list = params[:plant_diary][:tags].split(',') if params[:plant_diary][:tags]
    if @plant_diary.update(plant_diary_params)
      @plant_diary.tags.destroy_all
      @plant_diary.save_plan_tags(tag_list)
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
    redirect_to mypage_users_path
  end

  def search_tag
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @plant_diaries = @tag.plant_diaries
  end

  private

  def set_plant_diary
    @plant_diary = PlantDiary.find(params[:id])
  end

  def filter_activeUser
    user = @plant_diary.user
    unless user.is_active?
      flash[:alert] = "指定のユーザーは退会済みです"
      redirect_to mypage_path
    end
  end

  def confirm_owner
    unless @plant_diary.user == current_user || params[:admin_delete].present?
      flash[:alert] = "編集または削除する権限がありません"
      redirect_to plant_diaries_path
    end
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def plant_diary_params
    params.require(:plant_diary).permit(:title, :content, :user_id, :image)
  end
end
