class Public::CommunitymembersController < ApplicationController
  before_action :authenticate_user!

  def create
    community = Community.find(params[:community_id])
    user = current_user
    community.communitymembers.create(user: user)
    redirect_to community_path(community.id)
  end

  def destroy
    community = Community.find(params[:community_id])
    user = current_user
    community.communitymembers.find_by(user: user).destroy
    redirect_to community_path(community.id)
  end
end
