class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.bigint :super_category_id

      t.timestamps
    end

    add_foreign_key :categories, :categories, column: :super_category_id
  end
end
