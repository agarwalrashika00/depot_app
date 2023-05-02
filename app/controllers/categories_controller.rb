class CategoriesController < ApplicationController
  def index
    @categories = Category.includes(:sub_categories).where(super_category_id: nil)
  end
end
