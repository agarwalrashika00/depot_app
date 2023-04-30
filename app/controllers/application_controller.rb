class ApplicationController < ActionController::Base
  before_action :authorize
  before_action :set_i18n_locale_from_params
  before_action :set_execution_time
  attr_accessor :execution_time
  before_action :update_last_active

  protected
  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to login_url, notice: "Please log in"
    end
  end

  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        I18n.locale = params[:locale]
      else
        flash.now[:notice] =
          "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end

  def set_execution_time
    @execution_time = Time.now
  end

  def update_last_active
    if (Time.now - session[:last_active].to_time) > 5.minutes
      reset_session
      redirect_to login_url, notice: 'You were inactive for a long time. Please log in again to activate your session.'
    else
      session[:last_active] = Time.now
    end
  end
end
