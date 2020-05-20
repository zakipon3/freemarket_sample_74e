class AddReferencesSellerIdToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :seller, foreign_key:  {to_table: :users} ,after: :status_id
  end
end
