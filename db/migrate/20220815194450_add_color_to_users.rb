class AddColorToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :color, :string, default: '#3E503C', null: false
  end
end
