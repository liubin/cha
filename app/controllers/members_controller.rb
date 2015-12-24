class MembersController < ApplicationController
  def all
    @users = User.all.page params[:page]
  end

  def update
    @user = User.find(params[:id])
    @user.admin = !@user.admin
    @user.save
    redirect_to members_all_path
  end
end
