class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions 
  belongs_to_active_hash :prefecture 

  belongs_to :user, optional: true
  validates :prefecture_id, :address, :postal_code, :city, :house_number, presence: true
end
