class UniqueCartProductValidator < ActiveModel::Validator
  def validate(record)
    if LineItem.exists?(cart_id: record.cart_id, product_id: record.product_id)
      record.errors.add :base, "duplicate cart_id, product_id combination"
    end
  end
end