class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :current_account
  around_action :scope_current_account
  before_action :can_access_account?
  before_action :current_project
  around_action :scope_current_project
  before_action :configure_permitted_parameters, if: :devise_controller?


  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation,
      account_attributes: [:subdomain])
    }
  end

  def current_account
    @account = Account.find_by_subdomain(request.subdomain)
  end
  helper_method :current_account

  def current_project
    if params[:project_id].present?
      @project = params[:project_id]
      @current_project = Project.find(@project) if @project.present?
    elsif params[:controller] == "projects"
      @project = params[:id]
      @current_project = Project.find(@project) if @project.present?
    end
  end
  helper_method :current_project

  def scope_current_account
    Account.current_id = current_account.id if current_account.present?
      yield
    ensure
    Account.current_id = nil
  end

  def can_access_account?
    if current_user.present? && current_account.present?
      @permitted_account = current_user.account #identify a place to redirect user to
      unless current_user.account == current_account || current_user.accessible_accounts.include?(current_account)
        redirect_to subdomain_root_url(:subdomain => @permitted_account.subdomain), notice: 'You are not part of that account.'
      end
    end
  end

  def scope_current_project
    Project.current_id = current_project.id if current_project.present?
      yield
    ensure
    Project.current_id = nil
  end

  def after_sign_in_path_for(current_user)
   subdomain_root_url(:subdomain => current_user.account.subdomain)
  end
end
