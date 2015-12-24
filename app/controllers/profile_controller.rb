class ProfileController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :avatar]

  def show
    # ap @profile
  end

  def edit
  end

  def avatar
    if request.post?
      update
      return
    end
    # render avatar.html.slim
  end

  def update
    respond_to do |format|
      @profile.user = current_user
      if @profile.update(profile_params)
        format.html { redirect_to profile_path, notice: t('user.profile.msg.updated') }
      else
        format.html { render :edit }
      end
    end
  end

  private
    def set_profile
      @profile = current_user.profile || Profile.new
      @profile.user = current_user if @profile.user.nil?
    end

    def profile_params
      params.require(:profile).permit(:nick, :last_name, :first_name, :slug, :avatar)
    end
end
