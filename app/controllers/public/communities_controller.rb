class Public::CommunitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @community = Community.new
  end

  def index
    @plant_diary = PlantDiary.new
    @communities = Community.all
  end

  def show
    @plant_diary = PlantDiary.new
    @community = Community.find(params[:id])
  end

  def create
    @community = Community.new(community_params)
    @community.user_id = current_user.id
    @community.owner_id = current_user.id
    if @community.save
      flash[:notice] = 'コミュニティを作成しました。'
      redirect_to communities_path
    else
      flash.now[:alert] = @community.errors.full_messages.join(", ")
      render 'new'
    end
  end

  def edit
  end

  def destroy
    @community = Community.find(params[:id])
    @community.destroy
    flash[:notice] = 'コミュニティを削除しました。'
    redirect_to communities_path
  end

  def update
    if @community.update(community_params)
      flash[:notice] = 'コミュニティを更新しました。'
      redirect_to communities_path
    else
      flash.now[:alert] = @community.errors.full_messages.join(", ")
      render "edit"
    end
  end

  private

  def community_params
    params.require(:community).permit(:name, :introduction, :image, :user_id)
  end

  def ensure_correct_user
    @community = Community.find(params[:id])
    unless @community.owner_id == current_user.id
      flash[:alert] = '権限がありません。'
      redirect_to communities_path
    end
  end
end