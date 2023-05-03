class SessionsController < ApplicationController
  skip_before_action :authorize
  skip_before_action :update_last_active

  def new
    if session[:user_id]
      redirect_to store_index_url, notice: t('.already_logged')
    end
  end

  def create
    user = User.find_by(name: params[:name])
    if user.try(:authenticate, params[:password])
      session[:user_id] = user.id
      session[:last_active] = Time.now
      I18n.default_locale = LANGUAGES.to_h[user.language.capitalize]
      if user.role == 'admin'
        redirect_to admin_reports_url
      else
        redirect_to store_index_url
      end
    else
      redirect_to login_url, alert: 'Invalid user/password combination'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_index_url, notice: "Logged out"
  end
end
