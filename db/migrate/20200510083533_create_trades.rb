class CreateTrades < ActiveRecord::Migration[5.2]
  def change
    create_table :trades do |t|
      t.references :item,   null: false, foreign_key: true
      t.references :seller, foreign_key:  {to_table: :users}
      t.references :buyer,  foreign_key:  {to_table: :users}
      t.timestamps
    end
  end
end
