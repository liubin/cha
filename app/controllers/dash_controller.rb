class DashController < ApplicationController
  skip_before_filter :authenticate_user!
  layout 'devise'
  def index
  end
end
