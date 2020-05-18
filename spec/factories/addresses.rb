FactoryBot.define do

  factory :address do
    first_name              {"全角"}
    last_name               {"全角"}
    first_name_kana         {"カタカナ"}
    last_name_kana          {"カタカナ"}
    postal_code             {"000-0000"}
    prefecture_id           {1}
    city                    {"aaa"}
    house_number            {"aaa"}
  end
end