module ControllerHelpers
  def login(user)
    @request.env['devise_mapping'] = Devise.mappings[:user]
    sign_in_with(user)
  end
end