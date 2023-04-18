class LineItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :product
  belongs_to :cart, optional: true, counter_cache: true

  validates :cart_id, uniqueness: { scope: :product_id }

  def total_price
    product.price * quantity
  end
end
