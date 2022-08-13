class AddIndexToUsers < ActiveRecord::Migration[7.0]
  def change
    add_index :users, [:email, :nickname], unique: true
  end
end
