class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def check_if_team_member
    return if @project.team_members.include?(current_user)
    flash[:error] = 'Only project team members can access this.'
    redirect_to projects_path
  end

  protected

  def configure_permitted_parameters
    added_attrs = %i[username email password password_confirmation remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  protect_from_forgery with: :exception
end
