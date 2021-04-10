class ModifyTokensIndexes < ActiveRecord::Migration[6.1]
  def change
    remove_index :tokens, :location
    add_index :tokens, [:campaign_id, :location], unique: true
  end
end
