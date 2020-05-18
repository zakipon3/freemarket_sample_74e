class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  belongs_to :user, optional: true

  with_options presence: true do
    validates :prefecture_id
    validates :city
    validates :house_number
    validates :postal_code,   format: {with: /\A\d{3}[-]\d{4}\z/}
   
    with_options format: {with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/} do
      validates :first_name
      validates :last_name
    end
    with_options format: {with: /\A[ァ-ヶー－]+\z/} do
      validates :first_name_kana
      validates :last_name_kana
    end
  end
end



