class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :set_user, except: :failure

  def facebook

    if @user.persisted?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    end
  end

  def google_oauth2

    if @user.persisted?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, :kind => "Google") if is_navigational_format?
    end
  end

  def failure
    redirect_to root_path
  end

  private

  def set_user
    @user = User.from_omniauth(request.env["omniauth.auth"])
  end
end
