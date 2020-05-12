class Address < ApplicationRecord
  belongs_to :user, optional: true
  validates :prefecture_id, :address, :postal_code, :city, :house_number, presence: true
end
