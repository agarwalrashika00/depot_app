class Admin::ReportsController < ApplicationController
  def index
    user = User.find(session[:user_id])
    if user.admin?
      params[:from] ||= 5.days.ago
      @order =  Order.by_date(params[:from], params[:to])
    else
      redirect_to store_index_path, notice: "You don't have privilege to access this section"
    end
  end
end