class Category < ApplicationRecord
  has_many :sub_categories, class_name: "Category", foreign_key: "super_category_id", dependent: :destroy
  belongs_to :super_category, class_name: "Category", optional: true
  has_many :products, dependent: :restrict_with_error
  has_many :sub_categories_products, through: :sub_categories, source: :products, dependent: :restrict_with_error

  validates :name, presence: true
  validates :name, uniqueness: { scope: :super_category_id }, allow_blank: true
  validate :no_child_of_sub_categories

  after_update_commit :set_products_count, if: :super_category_changed?

  private

  def has_grandchild
    Category.exists?(super_category_id: sub_category_ids)
  end

  def no_child_of_sub_categories
    if super_category&.super_category_id? || has_grandchild || (super_category.present? && sub_categories.present?)
      errors.add :base, :nesting_level_too_deep, message: 'only one level of nesting is allowed'
    end
  end

  def super_category_changed?
    super_category_id_before_last_save != super_category_id
  end

  def set_products_count
    Category.find(super_category_id_before_last_save).decrement!(:products_count, products_count)
    super_category&.increment!(:products_count, products_count)
  end
end
