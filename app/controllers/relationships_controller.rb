class RelationshipsController < ApplicationController
  before_action :signed_in_user

  def create
    @user = User.find(params[:relationship][:shared_id])
    current_user.share!(@user)
    redirect_to @user
  end

  def destroy
    @user = Relationship.find(params[:id]).shared
    current_user.unshare!(@user)
    redirect_to @user
  end
end