class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :check_user_profile

  # Ensuring policies are used
  # after_action :verify_authorized, :except => :index

  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def check_user_profile
    return if current_user.nil?
    return if controller_name = 'profile' && (action_name == 'edit' || action_name == 'update')
    redirect_to(profile_edit_path) if current_user.profile.nil?
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  def after_sign_in_path_for(resource)
    books_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
