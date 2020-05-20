class AddReferencesBuyerIdToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :buyer, foreign_key:  {to_table: :users} ,after: :seller_id
  end
end
