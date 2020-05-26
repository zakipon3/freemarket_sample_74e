require 'rails_helper'

describe Creditcard do
  describe '#new' do

    it "全て入力すればカードを登録できる" do
      creditcard = create(:creditcard)
      expect(creditcard).to be_valid
    end

    it "user_idがない場合は登録できないこと" do
      creditcard = build(:creditcard, user_id: "")
      creditcard.valid?
      expect(creditcard.errors[:user_id]).to include("can't be blank")
    end

    it "customer_idがない場合は登録できないこと" do
      creditcard = build(:creditcard, customer_id: "")
      creditcard.valid?
      expect(creditcard.errors[:customer_id]).to include("can't be blank")
    end

    it "card_idがない場合は登録できないこと" do
      creditcard = build(:creditcard, card_id: "")
      creditcard.valid?
      expect(creditcard.errors[:card_id]).to include("can't be blank")
    end

  end
end