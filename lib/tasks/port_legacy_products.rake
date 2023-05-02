task :port_legacy_products => :environment do
  Product.where(category_id: nil).each do |product|
    product.update_columns(category_id: Category.first.id)
  end
end