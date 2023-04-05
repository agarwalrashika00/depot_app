class LineItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :product
  belongs_to :cart, optional: true

  before_create do
    validates :cart_id, uniqueness: { scope: :product_id }
  end

  def total_price
    product.price * quantity
  end 
end
