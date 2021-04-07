class CreateTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :tokens do |t|
      t.string :location, index: { unique: true }
      t.integer :status, limit: 1
    end
  end
end
