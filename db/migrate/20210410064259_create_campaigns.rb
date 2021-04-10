class CreateCampaigns < ActiveRecord::Migration[6.1]
  def change
    create_table :campaigns do |t|
      t.string :name, index: { unique: true }, null: false
      t.string :public_key, index: { unique: true }, null: false
      t.string :rebels_edit_key, index: { unique: true }, null: false
      t.string :rebels_status_key, index: { unique: true }, null: false
      t.string :imperial_status_key, index: { unique: true }, null: false
    end
  end
end
