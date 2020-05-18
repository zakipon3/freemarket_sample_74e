FactoryBot.define do

  factory :user do
    first_name                  {"全角"}
    last_name                   {"全角"}
    first_name_kana             {"カタカナ"}
    last_name_kana              {"カタカナ"}
    nickname                    {"abe"}
    birth_year                  {2020}
    birth_month                 {1}
    birth_day                   {1}
    email                       {"kkk@docomo.ne.jp"}
    password                    {"a000000"}
    password_confirmation       {"a000000"}
  end

end