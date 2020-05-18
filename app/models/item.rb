class Item < ApplicationRecord
  belong_to : user
  has_many : trades
  has_many : images
  belong_to : category
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :condition
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :days_until_shipping
  belongs_to_active_hash :status
end
