class Product < ApplicationRecord
  attr_accessor :essay
  attr_accessor :information
  has_many :line_items
  has_many :orders, through: :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }, allow_blank: true
  validates :price, comparison: { greater_than: :discount_price }
  validates :price, greater_than_discount: true, if: :discount_price?
  validates :title, uniqueness: true, allow_blank: true, length: {maximum: 28}
  validates :image_url, allow_blank: true, url: true
  validates :permalink, uniqueness: true, format: {
    with: PERMALINK_REGEXP
  }
  validates :description, word_count: { in: 5..10 }, allow_nil: true
  validates_length_of :essay,
    minimum: 5, 
    maximum: 10, 
    tokenizer: Proc.new { |str| str.scan(/\w+/) },
    too_short: "must have at least %{count} words",
    too_long: "must have at most %{count} words"
  validates :information, format: {
    with: /(\w+ \w+){4,}/
  }, allow_blank: true

  before_validation :set_title, unless: :title?

  after_initialize :set_discount_price, unless: :discount_price?

<<<<<<< HEAD
  before_validation :set_title, unless: :title?

  after_initialize :set_discount_price, unless: :discount_price?
=======
  before_validation :title_present?

  after_initialize :discount_price_present?
>>>>>>> d2e89f1 (callback after review 1)

  private
  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items present')
      throw :abort
    end
  end

<<<<<<< HEAD
  def set_title
    self.title = 'abc'
  end

  def set_discount_price
    self.discount_price = price 
=======
  def title_present?
    self.title = 'abc' unless title?
  end

  def discount_price_present?
    self.discount_price = price unless discount_price?
>>>>>>> d2e89f1 (callback after review 1)
  end
end
