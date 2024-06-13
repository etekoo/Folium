class Admin::CommunitiesController < ApplicationController
  before_action :authenticate_admin! # 管理者認証

  def index
    @communities = Community.all
  end

  def show
    @community = Community.find(params[:id])
  end

  def destroy
    @community = Community.find(params[:id])
    @community.destroy
    flash[:notice] = 'コミュニティを削除しました。'
    redirect_to admin_communities_path
  end

  private

end