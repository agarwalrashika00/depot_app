class Product < ApplicationRecord
  attr_accessor :essay, :information
  attr_accessor :image_params
  has_many :line_items, dependent: :restrict_with_error
  has_many :orders, through: :line_items
  has_many :carts, through: :line_items
  belongs_to :category, counter_cache: true
  has_many :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  # before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }, allow_blank: true
  validates :price, comparison: { greater_than: :discount_price }, allow_blank: true
  validates :price, greater_than_discount: true, if: :discount_price?
  validates :title, uniqueness: true, allow_blank: true, length: {maximum: 28}
  validates :image_url, allow_blank: true, url: true
  validates :permalink, uniqueness: true, allow_blank: true, format: {
    with: PERMALINK_REGEXP
  }
  validates :description, word_count: { in: 5..10 }, allow_nil: true
  validates_length_of :essay1,
    minimum: 5,
    maximum: 10,
    message: 'not in range',
    if: -> { essay.present? }
  validates :information, format: {
    with: /(\w+ \w+){4,}/
  }, allow_blank: true

  before_validation :set_title, unless: :title?

  before_validation :set_discount_price, unless: :discount_price?

  scope :enabled, -> { where(enabled: true) }

  after_save :set_count_on_save

  after_destroy_commit :set_count_on_destroy

  before_save :upload_images

  def upload_images
    (1...(image_params.length)).each do |i|
      images.build(url: image_params[i].original_filename)
      File.open(Rails.root.join('app', 'assets', 'images', image_params[i].original_filename), 'wb') do |f|
        f.write(image_params[i].read)
      end
    end
  end

  private
  # def ensure_not_referenced_by_any_line_item
  #   unless line_items.empty?
  #     errors.add(:base, 'Line Items present')
  #     throw :abort
  #   end
  # end

  def set_title
    self.title = 'abc'
  end

  def set_discount_price
    self.discount_price = price 
  end

  def essay1
    essay.split
  end

  def set_count_on_save
    if category_id_before_last_save
      Category.find(category_id_before_last_save).super_category&.decrement!(:products_count)
    end
    category.super_category&.increment!(:products_count)
  end

  def set_count_on_destroy
    category.super_category&.decrement!(:products_count)
  end
end
