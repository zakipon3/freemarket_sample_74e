class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  with_options presence: true do
    validates :nickname
    validates :birth_year
    validates :birth_month
    validates :birth_day
    validates :email,          uniqueness: {case_sensitive: false},
                               format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
    validates :password,       length: { minimum: 7 }
    # format: {with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{7,50}+\z/i}
    with_options format: {with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/} do
      validates :first_name
      validates :last_name
    end

    with_options format: {with: /\A[ァ-ヶー－]+\z/} do
      validates :first_name_kana
      validates :last_name_kana
    end

  end


  has_one :address
  # has_many :creditcards
  # has_many :trades
end
