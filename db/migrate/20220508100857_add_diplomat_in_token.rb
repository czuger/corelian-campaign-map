class AddDiplomatInToken < ActiveRecord::Migration[6.1]
  def change
    add_column :tokens, :diplomat, :bool, null: false, default: false
  end
end
