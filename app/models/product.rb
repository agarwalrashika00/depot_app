class Product < ApplicationRecord
  has_many :line_items
  has_many :orders, through: :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }, allow_nil: true
  validates :price, comparison: { greater_than: :discount_price }
  validates :price, greater_than_discount: true, if: -> { discount_price? }
  validates :title, uniqueness: true, allow_blank: true, length: {maximum: 28}
  validates :image_url, allow_blank: true, url: true
  validates :permalink, uniqueness: true, format: {
    with: PERMALINK_REGEXP
  }
  validates :description, word_count: { in: 5..10 }

  private
  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items present')
      throw :abort
    end
  end
end
