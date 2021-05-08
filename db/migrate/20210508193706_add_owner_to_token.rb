class AddOwnerToToken < ActiveRecord::Migration[6.1]
  def change
    add_column :tokens, :owner, :string, null: false
  end
end
