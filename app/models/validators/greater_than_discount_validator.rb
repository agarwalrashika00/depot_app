class GreaterThanDiscountValidator < ActiveModel::Validator
  def validate(record)
    if record.discount_price >= record.price
      record.errors.add :price, 'price should be greater than discount price'
    end
  end
end
