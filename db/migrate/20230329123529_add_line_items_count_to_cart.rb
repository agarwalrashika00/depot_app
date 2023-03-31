class AddLineItemsCountToCart < ActiveRecord::Migration[7.0]
  def change
    add_column :carts, :line_items_count, :integer, null: false, default: 0
  end
end
