class ModifyTokensTypes < ActiveRecord::Migration[6.1]
  def change
    change_column :tokens, :status, :string
  end
end
