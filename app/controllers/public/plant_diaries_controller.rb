class Public::PlantDiariesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_plant_diary, only: [:show, :edit, :update, :destroy]
  before_action :filter_active_user, only: [:show]
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
    tags = Vision.get_image_data(plant_diary_params[:image])
    @plant_diary.user_id = current_user.id

    if @plant_diary.save
      @plant_diary.save_plant_diary_tags(tag_list)
      flash[:notice] = '投稿に成功しました.'
      tags.each do |tag|
        @plant_diary.tags.create(name: tag)
      end
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
      @plant_diary.save_plant_diary_tags(tag_list)
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
    @tag = Tag.find(params[:tag_id])
    @plant_diaries = @tag.plant_diaries.includes(:user, :tags).where(users: { is_active: true })
    @tags = Tag.all
    render 'public/plant_diaries/search_tag'
  end

  private

  def set_plant_diary
    @plant_diary = PlantDiary.find(params[:id])
  end

  def filter_active_user
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

  def plant_diary_params
    params.require(:plant_diary).permit(:title, :content, :image)
  end
end
