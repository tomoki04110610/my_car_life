class Admin::DashboardsController < ApplicationController
  layout 'admin'

  def index
    @users = User.all
  end

end
