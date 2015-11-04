class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :current_account
  around_action :scope_current_account

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation,
      account_attributes: [:subdomain])
    }
  end

  def current_account
    @account = Account.find_by(subdomain: request.subdomain)
  end
  helper_method :current_account

  def scope_current_account
    Account.current_id = current_account.id if current_account.present?
      yield
    ensure
    Account.current_id = nil
  end

  def after_sign_in_path_for(current_user)
   subdomain_root_url(:subdomain => current_user.account.subdomain)
  end
end
