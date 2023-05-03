class SessionsController < ApplicationController
  skip_before_action :authorize
  skip_before_action :update_last_active

  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if user.try(:authenticate, params[:password])
      session[:user_id] = user.id
      session[:last_active] = Time.now
      if user.role == 'admin'
        redirect_to admin_reports_url
      else
        redirect_to admin_url
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
