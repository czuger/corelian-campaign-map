class CreateUser < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :uid, index: { unique: true }, null: false
      t.string :avatar, null: false

      t.timestamps
    end

    create_table :players do |t|
      t.references :user, null: false, foreign_key: true
      t.references :campaign, null: false, foreign_key: true
      t.string :side, null: true
      t.boolean :admin, null: false, default: false

      t.timestamps
    end

  end
end
