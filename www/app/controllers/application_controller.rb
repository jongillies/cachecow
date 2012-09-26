class ApplicationController < ActionController::Base

  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    redirect_to root_url, alert: exception.message
  end

  helper_method :app_name

  protected

  def app_name
    Rails.application.class.to_s.split("::").first
  end

end
