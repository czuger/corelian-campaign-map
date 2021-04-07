class CreateTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :tokens do |t|
      t.string :location, index: { unique: true }, null: false
      t.integer :status, limit: 1, null: false
    end
  end
end
