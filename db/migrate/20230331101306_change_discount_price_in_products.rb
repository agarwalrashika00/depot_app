class ChangeDiscountPriceInProducts < ActiveRecord::Migration[7.0]
  def up
    change_column :products, :discount_price, :decimal, precision: 6, scale: 2
  end

  def down
    change_column :products, :discount_price, :decimal
  end
end