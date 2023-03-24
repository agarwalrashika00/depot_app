class AddPriceToLineItems < ActiveRecord::Migration[7.0]
  def change
    add_column :line_items, :price, :decimal, precision: 8, scale: 2
  end

  # def up
  #   LineItem.update_all(price: Product.find(product_id).price)
  # end
end
