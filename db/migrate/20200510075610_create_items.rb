class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name,                    null: false
      t.integer :price,                  null: false
      t.text :explanation,               null: false
      t.references :category,            null: false, foreign_key: true
      t.string :size
      t.string :brand_name
      t.integer :condition_id,           null: false
      t.integer :delivery_fee_id,        null: false
      t.integer :prefecture_id,          null: false
      t.integer :days_until_shipping_id, null: false
      t.integer :status_id,              null: false
      t.timestamps
    end
  end
end
