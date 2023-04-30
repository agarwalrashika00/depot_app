class AdminController < ApplicationController
  before_action :if_admin?

  def index
    @total_orders = Order.count
  end

  def categories
    @categories = Category.all
  end

  private
  def if_admin?
    redirect_to store_index_url, notice: 'You donot have privileges to access this section.' unless User.find(session[:user_id]).admin?
  end
end
