class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to_active_hash :prefecture
  belongs_to_active_hash :condition
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :days_until_shipping

  belongs_to :category
  belongs_to :buyer, class_name: "User", foreign_key: "buyer_id", optional: true
  belongs_to :seller, class_name: "User", foreign_key: "seller_id", optional: true

  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :name, :explanation, :category_id, :condition_id, :delivery_fee_id, :prefecture_id, :days_until_shipping_id, :price, presence: true
  validates :name, length: { maximum: 40 }
  validates :price, numericality: { only_integer: true , greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  validates :images, presence: true
end
