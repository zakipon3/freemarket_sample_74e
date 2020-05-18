require 'rails_helper'
describe Address do
  describe '#create_address' do

    it "first_nameとlast_name、first_name_kanaとlast_name_kana、postal_code、prefecture_id、city、house_numberが存在すれば登録できること" do
      address = build(:address)
      expect(address).to be_valid
    end

    it "first_nameがない場合は登録できないこと" do
      address = build(:address, first_name: nil)
      address.valid?
      expect(address.errors[:first_name]).to include("can't be blank")
    end

    it "last_nameがない場合は登録できないこと" do
      address = build(:address, last_name: nil)
      address.valid?
      expect(address.errors[:last_name]).to include("can't be blank")
    end

    it "first_name_kanaがない場合は登録できないこと" do
      address = build(:address, first_name_kana: nil)
      address.valid?
      expect(address.errors[:first_name_kana]).to include("can't be blank")
    end

    it "last_name_kanaがない場合は登録できないこと" do
      address = build(:address, last_name_kana: nil)
      address.valid?
      expect(address.errors[:last_name_kana]).to include("can't be blank")
    end

    it "postal_codeがない場合は登録できないこと" do
      address = build(:address, postal_code: nil)
      address.valid?
      expect(address.errors[:postal_code]).to include("can't be blank")
    end

    it "prefecture_idがない場合は登録できないこと" do
      address = build(:address, prefecture_id: nil)
      address.valid?
      expect(address.errors[:prefecture_id]).to include("can't be blank")
    end

    it "cityがない場合は登録できないこと" do
      address = build(:address, city: nil)
      address.valid?
      expect(address.errors[:city]).to include("can't be blank")
    end

    it "house_numberがない場合は登録できないこと" do
      address = build(:address, house_number: nil)
      address.valid?
      expect(address.errors[:house_number]).to include("can't be blank")
    end
  end
end