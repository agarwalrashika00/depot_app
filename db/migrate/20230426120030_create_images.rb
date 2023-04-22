class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|
      t.string :url
      t.binary :image
      t.references :imageable, polymorphic: true

      t.timestamps
    end
  end
end
