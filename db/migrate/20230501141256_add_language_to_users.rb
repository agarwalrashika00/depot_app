class AddLanguageToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :language, :string, default: 'english'
  end
end
