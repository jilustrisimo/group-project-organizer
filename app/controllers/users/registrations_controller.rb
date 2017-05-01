class Users::RegistrationsController < Devise::RegistrationsController

  protected

  def update_resource(resource, params)
    providers = %w[facebook google_oauth2]
    if providers.include?(current_user.provider)
      params.delete('current_password')
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end
end
