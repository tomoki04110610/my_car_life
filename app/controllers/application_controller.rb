class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about], unless: :admin_controller?


  private

  def configure_authentication
    if admin_controller?
      authenticate_admin!
    else
      authenticate_user! unless action_is_public?
    end
  end

  def admin_controller?
    self.class.module_parent_name == 'Admin'
  end

  def action_is_public?
    controller_name == 'homes' && action_name == 'top'
  end

end
